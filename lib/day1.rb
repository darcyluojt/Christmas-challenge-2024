# TODO: you can build your christmas list program here!
require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 1
url = "https://adventofcode.com/2024/day/#{day}/input"


begin
  html_file = URI.open(
    url,
    "Cookie" => "session=#{session_cookie}",
    "User-Agent" => "Mozilla/5.0 (compatible; Ruby script; AdventOfCode)"
  ).read

  # Parse the HTML document
  html_doc = Nokogiri::HTML.parse(html_file)
  content = html_doc.at('p').text
  numbers = content.split.map(&:to_i)
  list1 = []
  list2 = []
  numbers.each_with_index do |number, index|
    if index.even?
      list1 << number
    else
      list2 << number
    end
  end
  list1 = list1.sort
  list2 = list2.sort
end

# CHALLENGE 1
pairs = list1.count - 1
difference = 0
list1.each_with_index do |number, index|
  difference += (list2[index] - number).abs
end
puts difference

# CHALLENGE 2
score = 0
list1.each do |number|
  result = list2.select { |num| num == number }
  score += result.count * number
end
puts score
