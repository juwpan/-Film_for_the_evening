require_relative 'lib/film_collection'
require 'colorize'
require 'colorized_string'

URL = 'http://www.kinoglobe.ru/index.php'

begin
  films_collection = FilmCollection.read_html(URL)
rescue SocketError
  films_collection = FilmCollection.from_dir(File.join(__dir__, 'data', 'films'))
end

# Массив всех продюссеров
directors = films_collection.directors

# Сама программа
puts 'Программа "Фильм на вечер"'.colorize(:blue)
puts

directors.uniq.each.with_index(1) do |director, index|
  puts "#{index}:#{director}"
end

puts 'Фильм какого режиссера вы хотите сегодня посмотреть?'

choice_user = gets.to_i - 1 # Выбор режисера пользователем

chosen_director = directors[choice_user]

film = films_collection.film_by_director(chosen_director)

puts film.sample
