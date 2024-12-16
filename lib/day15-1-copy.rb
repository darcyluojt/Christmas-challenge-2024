require "csv"

filepath = "./maze.csv"
# file_name = "./15.txt"
content = "###############
#.......#....E#
#.#.###.#.###.#
#.....#.#...#.#
#.###.#####.#.#
#.#.#.......#.#
#.#.#####.###.#
#...........#.#
###.#.#####.#.#
#...#.....#.#.#
#.#.#.###.#.#.#
#.....#...#.#.#
#.###.#.#.#.#.#
#S..#.....#...#
###############"
# content = File.read(file_name)

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


def compute_score(position, direction)
  i, j = position
  return {@end => nil} if position == @end
  visited_locations = {}
  POSSIBLE_DIRECTIONS.each do |a,b|
    next if MAZE[i+a][j+b] == -1
    if [a,b] == direction
      score = MAZE[i][j] + 1
    else
      score = MAZE[i][j] + 1001
    end
    next if MAZE[i+a][j+b] != nil && MAZE[i+a][j+b] < score

    MAZE[i+a][j+b] = score
    visited_locations.merge!(compute_score([i+a, j+b], [a,b]))
    p visited_locations
  end
  if visited_locations.empty?
    return {}
  else
    visited_locations[position] = nil
    return visited_locations
  end
end

compute_score(@start, [0,1])
p compute_score(@start, [0,1]).length
p MAZE[@end[0]][@end[1]]
