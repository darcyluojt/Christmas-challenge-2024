# TODO: you can build your christmas list program here!
require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 2
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
  content = content.split("\n")
  reports = content.map do |e|
    e.split(" ").to_a
  end
end


safe_report = []
def safe(array)
  # Standard 1: The levels are either all increasing or all decreasing.
  if array == array.sort || array == array.sort.reverse
    score1 = 0
  else
    score1 = 1
  end
  # Once score1 == 1 meaning stardard 1 is met, the next test is : Any two adjacent levels differ by at least one and at most three.
  diff = []
  array.each_cons(2) do |a,b|
    # if difference of a,b is between 1 and 3, append 0 to diff array, else append 1
    (1..3).include?((a - b).abs) ? diff << 0 : diff << 1
  end
  score2 = diff.sum
  # if score1 and score2 are both 0, then the array is safe
  return true if score1 == 0 && score2 == 0
end

def safe_possible(array)
  puts "array in safe possible: #{array}"
  array.each_with_index do |number, index|
    new_array = array.dup
    new_array.delete_at(index)
    return true if safe(new_array) == true
  end
  false
end




reports.each do |report|
  report.map!(&:to_i)
  safe_report << report if safe(report) == true
end

puts "safe_report: #{safe_report.length}"


possible_safe = reports - safe_report
possible_safe.each do |report|
  safe_report << report if safe_possible(report)
  # safe_possible(report)
end
puts "adjusted safe_report: #{safe_report.length}"
