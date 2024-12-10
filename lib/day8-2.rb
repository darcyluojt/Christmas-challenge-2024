require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 8
url = "https://adventofcode.com/2024/day/#{day}/input"


begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  # Parse the HTML document
  html_doc = Nokogiri::HTML.parse(html_file)
  content = html_doc.text
end

start_time = Time.now
lines = content.split("\n")
antenna = Hash.new { |hash, key| hash[key] = [] }
regex = /[a-zA-Z\d]/
# iterate each line and find the location of any digit or letter
lines.each_with_index do |line, row|
  line.chars.each_with_index do |char, col|
    if regex.match?(char)
      antenna[char] << [row, col]
    end
  end
end

row = lines.size
col = lines[0].chars.size
def in_the_grid?(row, column, location)
  return (location[0] >= 0 && location[0] < row) && (location[1] >= 0 && location[1] < column)
end

antinodes = []
# iterate through each antenna and find the distance between them
antenna.each do |key, values|
  values.each_with_index do |first_value, first_index|
    values.each_with_index do |second_value, second_index|
      if first_index == second_index
        next
      else
        height = first_value[0] - second_value[0] # -1   1
        width = first_value[1] - second_value[1] # 3   -3
        new_row = first_value[0]# + height
        new_col = first_value[1]# + width
        location = [new_row, new_col] #[0, 11] [3, 2]
        while in_the_grid?(row,col,location)
          antinodes << location
          new_row += height
          new_col += width
          location = [new_row, new_col]
        end
      end
    end
  end
end

p antinodes.uniq.size
end_time = Time.now
execution_time = end_time - start_time
puts "Execution Time: #{execution_time} seconds"
