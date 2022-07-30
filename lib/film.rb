class Film
  attr_reader :title, :director, :year

  def self.from_txt(path_file)
    file_content = File.readlines(path_file, chomp: true)

    new(file_content[0], file_content[1], file_content[2])
  end

  def initialize(title, director, year)
    @title = title
    @director = director
    @year = year
  end

  def to_s
    "Название: #{@title}, Режиссёр: #{director}, (#{@year} год)"
  end
end
