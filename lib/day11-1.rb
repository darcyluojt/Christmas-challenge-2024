content = "3028 78 973951 5146801 5 0 23533 857"
c_array = content.split(' ').map(&:to_i)
def blink(c_array)
  c_array.each_with_index do |n, i|
    if n == 0
      c_array[i] = 1
    elsif n.to_s.length % 2 == 0
      str = n.to_s
      len = str.length
      c_array[i] = [str[0..len/2-1].to_i, str[len/2..-1].to_i]
    else
      c_array[i] = n * 2024
    end
  end
  c_array.flatten
end

start_time = Time.now

25.times do
  c_array = blink(c_array)
end

p "size: #{c_array.size}"
end_time = Time.now
execution_time = end_time - start_time
puts "Execution Time: #{execution_time} seconds"
