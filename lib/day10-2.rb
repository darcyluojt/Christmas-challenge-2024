require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 10
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

map = content.split("\n")
map = map.map { |line| line.chars.map(&:to_i) }
head = []

map.each_with_index do |line, row|
  line.each_with_index do |char, col|
    head << [row, col] if char == 0
  end
end

DIRECTIONS = [[-1, 0], [1, 0], [0, -1], [0, 1]]

def result(position, map)
  i = position[0] # position row
  j = position[1] # position column
  h = map.size
  w = map[0].size
  value = map[i][j]
  reached = []
  if value == 9
    reached << [i, j]
  else
    next_value = value + 1
    DIRECTIONS.each do |a, b|
      row = i + a
      column = j + b
      if (row >= 0 && row < h) && (column >= 0 && column < w) && map[row][column] == next_value
        reached += result([row, column], map)
      end
    end
  end
  reached
end

reached = {}
head.each do |position|
  reached[position] = result(position, map)
end

score = 0
reached.each do |key, value|
  score += value.uniq.size
end
p score
end_time = Time.now
execution_time = end_time - start_time
puts "Execution Time: #{execution_time} seconds"
