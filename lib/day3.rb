require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 3
url = "https://adventofcode.com/2024/day/#{day}/input"


def find_matches(input)
  pattern = /mul\((\d{1,3}),(\d{1,3})\)/
  # pattern = /mul[\(\[](\d{1,3}),(\d{1,3})[\)\]]/
  matches = input.scan(pattern)
  numbers = matches.map do |a,b|
    a.to_i * b.to_i
  end
  numbers.sum
end


begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  # Parse the HTML document
  html_doc = html_file.split("do")
end

# find_matches(html_file)
dos = []
dos << html_doc[0]
donts =[]

html_doc.delete_at(0)
html_doc.each do |line|
  if line.start_with?("()")
    dos << line
  elsif line.start_with?("n't()")
    donts << line
  end
end

sum = 0
puts dos[0..5]
dos.each do |line|
  sum += find_matches(line)
end

puts sum
