require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 4
url = "https://adventofcode.com/2024/day/#{day}/input"


times = 0
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

lines = content.split("\n")
def match_position(content, regex)
  positions = []
  offset = 0
  while match = regex.match(content, offset)
    positions << match.begin(0) # Add the starting position of the match
    offset = match.begin(0)+1       # Move the offset forward to continue searching
  end
  positions
end

  def diagonal_line(lines_array)
    baseline = lines_array[0].chars
    d_lines = []
    baseline.each_with_index do |letter, index|
      string = ""
      lines_array.each_with_index do |line, second_index|
        position = second_index + index
        string += line[position] if position < line.size
      end
      d_lines << string
    end
    d_lines
  end

  # case 1: the left right triangle part
  d_lines = []
  # iterate through the first to the last 4th letter of the first line
  reverse_lines = lines.reverse
  reverse_reverse = reverse_lines.map(&:reverse)
  d_lines << diagonal_line(reverse_reverse).reverse.map(&:reverse)
  d_lines << diagonal_line(lines)
  d_lines = d_lines.flatten.uniq!
  diagnoal_string = d_lines.join("n")
  # puts d_lines
  positions = match_position(diagnoal_string, /MAS|SAM/)

  position_array = []
  # i_size here is the scale of the grid
  i_size = lines.size
  condition = (2 + (i_size + 1)) * i_size / 2
  p condition
  positions.each do |position|
    new_string = diagnoal_string[0..position+1]
    string_array = new_string.split("n")
    n = string_array.size
    if new_string.size < condition
      x = string_array[-1].size - 1
      y = x - n
    # find the distance from the last n to the position number
    else
      # p "n: #{n}; last: #{string_array[-1]}"
      x = n - i_size + string_array[-1].size - 1
      y = string_array[-1].size - 1
    end
    position_array << [x, y]
  end
  p position_array
  p position_array.count
  xmas = 0
  position_array.each do |a|
    regex = /MAS|SAM/
    str = ""
    line = a[1]
    column = a[0]
    str += lines[line - 1][column + 1]
    str += "A"
    str += lines[line + 1][column - 1]
    if str.match(regex)
      xmas += 1
      p a
    end
  end
  puts xmas


  # reverse direction of the same part


  # location = {}
  # positions.each do |position|
  #   new_string = diagnoal_string[0..position+1]
  #   line = new_string.count("n") + 1
