# # require "matrix"
# content= "Button A: X+94, Y+34
# Button B: X+22, Y+67
# Prize: X=8400, Y=5400

# Button A: X+26, Y+66
# Button B: X+67, Y+21
# Prize: X=12748, Y=12176

# Button A: X+17, Y+86
# Button B: X+84, Y+37
# Prize: X=7870, Y=6450

# Button A: X+69, Y+23
# Button B: X+27, Y+71
# Prize: X=18641, Y=10279"

file_name = "./13-1.txt"
content = File.read(file_name)
content = content.split("\n\n")
games = []
content.map do |line|
  game = []
  buttons = line.split("\n")
  buttons.each do |button|
    button = button.split(", ")
    a,b = button
    a = a.scan(/\d+/).map(&:to_i)
    b = b.scan(/\d+/).map(&:to_i)
    game << a
    game << b
  end
  games << game.flatten!
end

p games
def token(array)
  a,b,c,d,x,y = array
  x += 10000000000000
  y += 10000000000000
  numerator1 = d * x - c * y
  denominator1 = a * d - b * c
  puts "numerator1: #{numerator1}, denominator1: #{denominator1}"
  return 0 if denominator1 == 0
  return 0 if numerator1 % denominator1 != 0
  numerator2 = b * x - a * y
  denominator2 = b * c - a * d
  puts "numerator2: #{numerator2}, denominator2: #{denominator2}"
  return 0 if denominator2 == 0
  return 0 if numerator2 % denominator2 != 0
  m = numerator1 / denominator1
  n = numerator2 / denominator2
  3 * m + n
end

total = 0
games.each do |game|
  total += token(game)
  puts '---'
end

p total
