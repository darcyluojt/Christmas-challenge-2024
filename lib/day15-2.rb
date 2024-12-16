require "csv"
filepath = "./maze.csv"
# MAZE = []
# CSV.foreach(filepath) do |row|
#   row.map! do |cell|
#     unless cell == "-1"
#       cell.to_i
#     end
#     cell.to_i % 1000
#   end
#   MAZE << row
# end
file_name = "./15.txt"
content = File.read(file_name)
content = content.split("\n")

ORIGINAL = []
CSV.foreach(filepath) do |row|
  row.map! do |cell|
    cell.to_i
  end
  ORIGINAL << row
end

content.each_with_index do |row, i|
  row.chars.each_with_index do |char, j|
    if char == "S"
      @start = [i, j]
    elsif char == "E"
      @finish = [i, j]
    end
  end
end
POSSIBLE_DIRECTIONS = [[-1,0],[1,0],[0,-1],[0,1]]

def count_tiles(position)
  i, j = position
  v = ORIGINAL[i][j]
  @counted ||= []
  return @counted if position == @finish
  POSSIBLE_DIRECTIONS.each do |a,b|
    next if ORIGINAL[i+a][j+b] == -1
    next if @counted.include?([i+a, j+b])
    if ORIGINAL[i+a][j+b] == v + 1 || ORIGINAL[i+a][j+b] == v + 1001 || ORIGINAL[i+a][j+b] == v - 999
      @counted << [i+a, j+b]
      count_tiles([i+a, j+b])
    end
  end
  @counted
end

all_tiles = count_tiles(@start)
p all_tiles.size
