file_name = "./14.txt"
content = File.read(file_name)

content = content.split("\n")
robots = content.map do |row|
  a,b,c,d = row.scan(/-?\d+/).map(&:to_i)
  [[a,b], [c,d]]
end

REGEX = /[1-9]{10,}/
HEIGHT = 103 # 103
WIDTH = 101 # 101
map = Array.new(HEIGHT) { Array.new(WIDTH, 0) }

def one_move(robots=[],original_map)
  times = 0
  loop do
    times += 1
    map = original_map.map(&:dup)
    robots.each do |robot|
      col, row = robot[0]
      vcol, vrow = robot[1]
      column = col + vcol * times
      row = row + vrow * times
      if column >= WIDTH || column < 0
        column = column % WIDTH
      end
      if row >= HEIGHT || row < 0
        row = row % HEIGHT
      end
      map[row][column] += 1
    end
  # check map value either 0 or 1
  filter = []
  map.each_with_index do |row, i|
    string = row.join
    next if REGEX.match(string).nil?
    filter << i
  end
  # loop again if match is nil
  next if filter.size < 2
  puts "filter: #{filter}, times: #{times}"
  filter.sort!
  shape = map[filter[0]..filter[-1]]
  shape = shape.transpose
  filter2 = []
  shape.each_with_index do |row, i|
    next if REGEX.match(row.join).nil?
    filter2 << i
  end
  filter2.sort!
  shape = shape[filter2[0]..filter2[-1]]
  mid = shape.size / 2
  up = shape[0..mid-1]
  down = shape[mid+1..-1]
  break if up == down.reverse
  end
  times
end

start = Time.now
p start
p one_move(robots, map)

end_time = Time.now
p end_time - start
