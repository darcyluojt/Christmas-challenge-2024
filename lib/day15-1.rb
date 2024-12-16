require "csv"

filepath = "./maze.csv"
file_name = "./15.txt"
content = File.read(file_name)
content = "#################
#...#...#...#..E#
#.#.#.#.#.#.#.#.#
#.#.#.#...#...#.#
#.#.#.#.###.#.#.#
#...#.#.#.....#.#
#.#.#.#.#.#####.#
#.#...#.#.#.....#
#.#.#####.#.###.#
#.#.#.......#...#
#.#.###.#####.###
#.#.#...#.....#.#
#.#.#.#####.###.#
#.#.#.........#.#
#.#.#.#########.#
#S#.............#
#################"

content = content.split("\n")
@walls = []
content.each_with_index do |row, i|
  row.chars.each_with_index do |char, j|
    if char == "#"
      @walls << [i, j]
    elsif char == "S"
      @start = [i, j]
    elsif char == "E"
      @end = [i, j]
    end
  end
end

height = content.size
width = content[0].size
MAZE = Array.new(height) { Array.new(width, nil) }
@walls.each do |wall|
  row, col = wall
  MAZE[row][col] = -1
end
start_row, start_col = @start
MAZE[start_row][start_col] = 0
POSSIBLE_DIRECTIONS = [[-1,0],[1,0],[0,-1],[0,1]]
TURN = {}
def compute_score(position, direction)
  i, j = position
  return MAZE[i][j] if position == @end
  POSSIBLE_DIRECTIONS.each do |a,b|
    next if MAZE[i+a][j+b] == -1
    if [a,b] == direction
      score = MAZE[i][j] + 1
    else
      score = MAZE[i][j] + 1001
    end
    next if MAZE[i+a][j+b] != nil && MAZE[i+a][j+b] < score
    MAZE[i+a][j+b] = score
    compute_score([i+a, j+b], [a,b])
  end
end

compute_score(@start, [0,1])
x,y = @end
puts MAZE[x][y]

CSV.open(filepath, "wb") do |csv|
  MAZE.each do |row|
    csv << row
  end
end
