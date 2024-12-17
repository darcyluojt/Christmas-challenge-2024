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
def count_word(content)
  content.scan(/(?=MAS)/).size + content.scan(/(?=SAM)/).size
end

# case 1: see horizontally, how many XMAS or SAMX
times = count_word(content)
puts times

# case 2: see vertically, how many XMAS or SAMX
i = 0
index = lines.size - 1
vertical_string = ""
lines.size.times do
  # imagine it starts with the first letter of all lines
  lines.each do |line|
    vertical_string += line[i]
  end
  vertical_string += "n"
  i += 1
# end

# times += count_word(vertical_string)
# puts times

# case 3: see diagonally to the right, how many XMAS or SAMX
  def diagonal_line(lines_array)
    baseline = lines_array[0][0..-4].chars
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

  d_lines = []
  # iterate through the first to the last 4th letter of the first line
  d_lines << diagonal_line(lines)
  reverse_lines = lines.reverse
  reverse_reverse = reverse_lines.map(&:reverse)
  d_lines << diagonal_line(reverse_reverse)
  d_lines.flatten!
  d_lines.delete_at(0)
  diagonal_string = d_lines.join("n")
  times += count_word(diagonal_string)
  puts times

# case 4: see diagonally to the left, how many XMAS or SAMX
  d2_lines = []
  d2_lines << diagonal_line(reverse_lines)
  d2_lines << diagonal_line(lines.map(&:reverse))
  d2_lines.flatten!
  d2_lines.delete_at(0)
  diagonal_string2 = d2_lines.join("n")
  times += count_word(diagonal_string2)
  puts times
