content = "3028 78 973951 5146801 5 0 23533 857"

# Initialize the queue with integers from the content
queue = content.split(' ').map(&:to_i)

# Process 75 blinks
times = 0
75.times do
  times += 1
  p times
  new_queue = []
  queue.each do |n|
    if n == 0
      new_queue << 1
    else
      digits = n.to_s
      if digits.length.even?
        half = digits.length / 2
        new_queue << digits[0, half].to_i
        new_queue << digits[half..-1].to_i
      else
        new_queue << n * 2024
      end
    end
  end
  queue = new_queue
end

# Output the number of elements in the final queue
puts "Total numbers after 75 blinks: #{queue.size}"
