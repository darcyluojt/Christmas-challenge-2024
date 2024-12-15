file_name = "./14.txt"
content = File.read(file_name)

# content = "p=0,4 v=3,-3
# p=6,3 v=-1,-3
# p=10,3 v=-1,2
# p=2,0 v=2,-1
# p=0,0 v=1,3
# p=3,0 v=-2,-2
# p=7,6 v=-1,-3
# p=3,0 v=-1,-2
# p=9,3 v=2,3
# p=7,3 v=-1,2
# p=2,4 v=2,-3
# p=9,5 v=-3,-3
# "

content = content.split("\n")
robots = content.map do |row|
  a,b,c,d = row.scan(/-?\d+/).map(&:to_i)
  [[a,b], [c,d]]
end


HEIGHT = 103 # 103
WIDTH = 101 # 101
map = Array.new(HEIGHT) { Array.new(WIDTH, 0) }


def move(position, velocity, moves)
  column, row = position
  dcol, drow = velocity
  return [column, row] if moves == 0
  column += dcol
  row += drow
  if column >= WIDTH || column < 0
    column = column % WIDTH
  end
  if row >= HEIGHT || row < 0
    row = row % HEIGHT
  end
  move([column, row], velocity, moves - 1)
end

robots.each do |robot|
  position = move(robot[0], robot[1], 100)
  col, row = position
  map[row][col] += 1
end

map.each do |row|
  p row
end

mid_row = HEIGHT / 2
mid_col = WIDTH / 2
quadrant1, quadrant2, quadrant3, quadrant4 = 0, 0, 0, 0
map.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    next if cell == 0
    if i < mid_row && j < mid_col
      quadrant1 += cell
    elsif i < mid_row && j > mid_col
      quadrant2 += cell
    elsif i > mid_row && j < mid_col
      quadrant3 += cell
    elsif i > mid_row && j > mid_col
      quadrant4 += cell
    end
  end
end

p "Quadrant 1: #{quadrant1}; Quadrant 2: #{quadrant2}; Quadrant 3: #{quadrant3}; Quadrant 4: #{quadrant4}"
safety = quadrant1 * quadrant2 * quadrant3 * quadrant4
p safety
