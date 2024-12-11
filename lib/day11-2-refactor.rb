# recursive function and cache is KING!!! From many hours to 0.16 seconds
MEMO = {}
def count(n, blinks_left)
  return 1 if blinks_left <= 0
  return count(1, blinks_left-1) if n == 0
  str = n.to_s
  len = str.length
  key = [n, blinks_left]
  return MEMO[key] if MEMO[key]
  if len.even?
    half = len / 2
    divisor = 10 ** half
    left = n / divisor
    right = n % divisor
    result = count(left, blinks_left-1) + count(right, blinks_left-1)
  else
    result = count(n * 2024, blinks_left-1)
  end
  MEMO[key] = result
  result
end

start_time = Time.now
p "start_time: #{start_time}"
content = "3028 78 973951 5146801 5 0 23533 857"
numbers = content.split(' ').map(&:to_i)
size = 0
numbers.each do |n|
  p "n: #{n}"
  size += count(n, 75)
end
p "size: #{size}"
end_time = Time.now
execution_time = end_time - start_time
puts "Execution Time: #{execution_time} seconds"
