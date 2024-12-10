require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 9
url = "https://adventofcode.com/2024/day/#{day}/input"

begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  content =  html_file.split("\n")[0]
end

# content = "2333133121414131402"

map = content.chars.map(&:to_i)
i = 0
numbers = []
spaces = []
space = "."
compact = []
hash = {}
start_time = Time.now

map.each_slice(2) do |a,b|
  number = []
  a.times do
    number << i
  end
  numbers << number
  unless b.nil?
    space = []
    b.times do
      space << false
    end
    spaces << space
  end
  i += 1
end

puts "numbers: #{numbers[0,100]}"
puts "spaces: #{spaces[0,100]}"

size = numbers.size
numbers.reverse.each_with_index do |number, index|
  spaces.each_with_index do |space,i|
    if space.count(false) >= number.size && i < (size - index - 1)
      number.size.times do
        false_in = space.index(false)
        space[false_in] = number[0]
      end
      new_array = Array.new(number.size, false)
      numbers[size - index - 1] = new_array
      break
    else
      next
    end
  end
end
p "---------------"
p "numbers: #{numbers[0,100]}"
p "spaces: #{spaces[0,100]}"

# check empty numb arrays
check = numbers.select { |number| number.empty? }
p "empty arrays: #{check.size}"
space_check = spaces.select { |space| space.empty? }
p "empty spaces: #{space_check.size}"
p "---------------"

compact = []
numbers.each_with_index do |number, index|
  compact << number
  unless spaces[index].nil?
    compact << spaces[index] if number != false
  end
end

compact.flatten!

p "file blocks: #{compact[0,100]}; size: #{compact.size}"



# p "processed compact string: #{compact}; size: #{compact.chars.size}"
checksum = 0
compact.each_with_index do |char, index|
  checksum += char * index unless char.nil? || char == false
#   # p "char: #{char}; index: #{index}; checksum: #{checksum}"
end

# p compact[0,200]
# p compact[-200..-1]
p checksum
end_time = Time.now
execution_time = end_time - start_time
puts "Execution Time: #{execution_time} seconds"
