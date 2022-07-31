class Film
  attr_reader :title, :director, :year

  def self.from_txt(path_file)
    file_content = File.readlines(path_file, chomp: true)

    new(file_content[0], file_content[1], file_content[2], file_content[3], file_content[4])
  end

  def initialize(title, director, year, descr, link)
    @title = title
    @director = director
    @year = year
    @descr = descr
    @link = link
  end

  def to_s
    <<~FILM
    Название: #{@title.colorize(:red)}
    Режиссёр: #{@director.colorize(:red)}
    Описание: #{@descr.colorize(:light_blue)}
    (#{@year.to_s.colorize(:green)} год)

    Ссылка: #{@link.join.colorize(:green)}
    FILM
  end
end
