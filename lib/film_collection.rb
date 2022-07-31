require 'open-uri'
require 'nokogiri'
require_relative 'film'

class FilmCollection
  attr_reader :films

  class << self
    # Считывает из папки Дата
    def from_dir(dir_path)
      films = Dir[File.join(dir_path, '*.txt')].map { |file_path| Film.from_txt(file_path) }

      new(films)
    end

    # Считывает с URL
    def read_html(url)
      document_html = Nokogiri::HTML5::Document.parse(URI.open(url), encoding = 'UTF-8')

      films_collections = []

      document_html.css('.content').each do |text|
        title = text.css('.title').text
        director = text.css('.director').children[1].text.strip
        year = text.css('.year').children[1].text.strip.to_i
        descr = text.css('.descr').children[1].text
        link = text.css('.go_watch a').map { |link| link['href'] }

        films_collections << Film.new(title, director, year, descr, link)
      end
      new(films_collections)
    end
  end

  def initialize(films)
    @films = films
  end

  def directors
    @films.map(&:director).uniq.sort
  end

  def film_by_director(chosen_director)
    @films.select { |film| film.director == chosen_director }
  end
end
