require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
day = 9
session_cookie = ENV['SESSION_COOKIE']

url = "https://adventofcode.com/2024/day/#{day}/input"


begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  content =  html_file.split("\n")[0]
end

map = content.chars.map(&:to_i)
i = 0
blocks = []
space = "."
compact = []
start_time = Time.now

map.each_slice(2) do |a,b|
  a.times do
    blocks << i.to_s

  end
  unless b.nil?
    b.times do
      blocks << "."
    end
  end
  i += 1
end

puts "file blocks: #{blocks[0,200]}; size: #{blocks.size}"
puts "file blocks: #{blocks[-200..-1]}; size: #{blocks.size}"

blocks.each do |char|
  if char.match(/\d/)
    compact << char
  else
    while blocks[-1].match(/\D/)
      blocks.delete_at(-1)
    end
    compact << blocks[-1]
    blocks.delete_at(-1)
  end
end

checksum = 0
compact.each_with_index do |char, index|
  checksum += char.to_i * index
end

p checksum
end_time = Time.now
execution_time = end_time - start_time
puts "Execution Time: #{execution_time} seconds"
