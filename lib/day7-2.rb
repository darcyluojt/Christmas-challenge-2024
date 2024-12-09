require "open-uri"
require "nokogiri"
require 'dotenv'

Dotenv.load
session_cookie = ENV['SESSION_COOKIE']
day = 7
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
end
# content = "190: 10 19
# 3267: 81 40 27
# 83: 17 5
# 156: 15 6
# 7290: 6 8 6 15
# 161011: 16 10 13
# 192: 17 8 14
# 21037: 9 7 18 13
# 292: 11 6 16 20"

equations = content.split("\n")
equations = equations.map { |line| line.split(": ") }
equations = equations.map { |line| line.map { |part| part.split(" ").map(&:to_i) } }

def operations(values)
  number = values.size - 1
  Enumerator.new do |yielder|
    [true,false].repeated_permutation(number) do |sequence|
      yielder << sequence
    end
  end
end

def evaluate_equation(equation)
  values = equation[1]
  results = []
  # get all possible operation combinations in this array
  combinations = operations(values)
  # iterate through each possibility of operation combinations
  combinations.each do |operations|
    sum = values[0]
    # in one instance of operation combinations, iterate each operator (boolean values)
    operations.each_with_index do |operation, index|
      if operation == true
        sum *= values[index+1]
      else
        sum += values[index+1]
      end
    end
    results << sum
    if sum == equation[0][0]
      return true
    end
  end
  # p "results: #{results}. equation: #{equation[0][0]}"
  results.include?(equation[0][0])
end

def operations_r2(values)
  number = values.size - 1
  Enumerator.new do |yielder|
    [1, 2, 3].repeated_permutation(number) do |sequence|
      yielder << sequence
    end
  end
end

def evaluate_equation_r2(equation)
  values = equation[1]
  results = []
  # get all possible operation combinations in this array
  combinations = operations_r2(values)
  # iterate through each possibility of operation combinations
  combinations.each do |operations|
    sum = values[0]
    # in one instance of operation combinations, iterate each operator (boolean values)
    operations.each_with_index do |operation, index|
      if operation == 1
        sum *= values[index+1]
      elsif operation == 2
        sum += values[index+1]
      else
        sum = (sum.to_s + values[index+1].to_s).to_i
      end
    end
    results << sum
    if sum == equation[0][0]
      return true
    end
  end
  # p "results: #{results}. equation: #{equation[0][0]}"
  results.include?(equation[0][0])
end

start_time = Time.now

valid = 0
pending = []
equations.each do |equation|
  if evaluate_equation(equation)
    valid += equation[0][0]
  else
    pending << equation
  end
end

puts valid
marker_time = Time.now

p "Time to evaluate all equations: #{marker_time - start_time} seconds using boolean operations"
pending.each do |equation|
  if evaluate_equation_r2(equation)
    valid += equation[0][0]
  end
end
puts valid

end_time = Time.now
execution_time = end_time - marker_time
puts "Execution Time: #{execution_time} seconds"
