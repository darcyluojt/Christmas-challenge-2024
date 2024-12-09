require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 6
url = "https://adventofcode.com/2024/day/#{day}/input"


begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  # Parse the HTML document
  html_doc = Nokogiri::HTML.parse(html_file)
  input = html_doc.text
end


data = input.split("\n")
x_data = data.dup
# find the start position ^
position = input.index("^") + 1
# start suppose to be lie [6, 4]
position_row = position / (data[0].size + 1) + 1
position_column = position % (data[0].size + 1) - 1  # 2
START_PO = [position_row, position_column]

# find the barriers #
barriers = []
data.each_with_index do |line, row|
  line.chars.each_with_index do |char, column|
    barriers << [row, column] if char == "#"
  end
end
DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]] # up, right, down, left

def get_next_move(position, direction, data)
  row = position[0] + direction[0]
  column = position[1] + direction[1]
  if (0 < row && row < data.size) || (0 < column && column < data[0].size)
    [row, column]
  else
    nil
  end
end

def turning_right(turn)
  i = DIRECTIONS.index(turn)
  if i == 3
    DIRECTIONS[0]
  else
    DIRECTIONS[i + 1]
  end
end

def infinite_path(barriers, data)
  max = data.size * data[0].size / 2
  turn = DIRECTIONS[0]
  next_move = get_next_move(START_PO, turn, data)
  i = 0
  max.times do
    if data[next_move[0]].nil? || data[next_move[0]][next_move[1]].nil?
      break
    else
      if barriers.include?(next_move)
        last_move = [next_move[0] - turn[0], next_move[1] - turn[1]]
        turn = turning_right(turn)
        next_move = get_next_move(last_move, turn, data)
      else
        data[next_move[0]][next_move[1]] = "X"
        next_move = get_next_move(next_move, turn, data)
      end
    end
    i += 1
  end
  i == max
end

# start moving
turn = DIRECTIONS[0]
# add another barriers
infinite = 0
data.each_with_index do |line, row|
  line.chars.each_with_index do |char, column|
    if barriers.include?([row, column])
      next
    else
      new_barriers = barriers.dup
      new_barriers << [row, column]
    end
    infinite += 1 if infinite_path(new_barriers, data)
  end
end
p infinite
# next_move = get_next_move(start, turn, data)
# x_data[next_move[0]][next_move[1]] = "X"


# until data[next_move[0]].nil? || data[next_move[0]][next_move[1]].nil?
#   if barriers.include?(next_move)
#     last_move = [next_move[0] - turn[0], next_move[1] - turn[1]]
#     # puts "hit barrier. barrier is #{next_move}, now turn #{turn} in #{last_move}"
#     turn = turning_right(turn)
#     next_move = get_next_move(last_move, turn, data)
#   else
#     x_data[next_move[0]][next_move[1]] = "X"
#     next_move = get_next_move(next_move, turn, data)
#   end
# end

# x_count = 0
# x_data.each do |line|
#   x_count += line.count("X")
# end
# p x_count
