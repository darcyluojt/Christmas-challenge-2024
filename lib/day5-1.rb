require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 5
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
  big_array = content.split("\n")
  rules = []
  updates = []
  big_array.each do |line|
    if line.include?("|")
      rules << line
    else
      updates << line
    end
  end
  rules.delete_if { |line| line.empty? }
  rules.map! { |line| line.split("|").map(&:to_i) }
  updates.delete_if { |line| line.empty? }
  updates.map! { |line| line.split(",").map(&:to_i) }
end

p rules[0..20]
p updates[0..20]


rules_head = []
rules_tail = []
rules.each do |rule|
  rules_head << rule[0]
  rules_tail << rule[1]
end
rules_head_uniq = rules_head.uniq
rules_processed = {}
rules_head_uniq.each do |head|
  rules_processed[head] = []
  rules_head.each_with_index do |instance, index|
    if instance == head
      rules_processed[head] << rules_tail[index]
    end
  end
end
all_numbers = rules_head + rules_tail
all_numbers.uniq!
good_order = []
task2 = []

updates.each do |update|
  right_order = true
  update.each_cons(2) do |a,b|
    if rules_processed[a].nil? || !rules_processed[a].include?(b)
      right_order = false
      break # Exit the loop early if the condition fails
    end
  end
  if right_order
    index = update.size / 2
    good_order << update[index]
  else
    task2 << update
  end
end
puts good_order.sum
p task2[0..20]
