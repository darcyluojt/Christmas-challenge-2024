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

# rules = "47|53
# 97|13
# 97|61
# 97|47
# 75|29
# 61|13
# 75|53
# 29|13
# 97|29
# 53|29
# 61|53
# 97|53
# 61|29
# 47|13
# 75|47
# 97|75
# 47|61
# 75|61
# 47|29
# 75|13
# 53|13"
# updates = "75,47,61,53,29
# 97,61,53,29,13
# 75,29,13
# 75,97,47,61,53
# 61,13,29
# 97,13,75,29,47"
# rules = rules.split("\n")
# rules = rules.map { |line| line.split("|").map(&:to_i) }
# updates = updates.split("\n")
# updates = updates.map { |line| line.split(",").map(&:to_i) }

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
good_order = []
task2 = []
def test_good_order(rules, order)
  right_order = true
  order.each_cons(2) do |a,b|
      if rules[a].nil? || !rules[a].include?(b)
        right_order = false
        break # Exit the loop early if the condition fails
      end
    end
  right_order
end

updates.each do |update|
  if test_good_order(rules_processed, update)
    index = update.size / 2
    good_order << update[index]
  else
    task2 << update
  end
end

tasks = task2
p tasks
# now only work on the not right order
def order_fixing(rules, order)
  i = 0
  order.each_cons(2) do |a,b|
    if rules[a].nil? && rules[b].nil?
      next
    elsif rules[b]&.include?(a)
      order[i], order[i+1] = order[i+1], order[i]
    end
    i += 1
  end
  order
end

tasks.each do |update|
  until test_good_order(rules_processed, update)
    update = order_fixing(rules_processed, update)

  end
end

new_order = []
tasks.each do |line|
  index = line.size / 2
  new_order << line[index]
end
puts new_order.sum
