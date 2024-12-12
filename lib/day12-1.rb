
file_name = "./12-1.txt"
content = File.read(file_name)

# content = "RRRRIICCFF
# RRRRIICCCF
# VVRRRCCFFF
# VVRCCCJFFF
# VVVVCJJCFE
# VVIVCCJJEE
# VVIIICJJEE
# MIIIIIJJEE
# MIIISIJEEE
# MMMISSJEEE"
map = content.split("\n").map { |row| row.split('') }
DIR = [[-1, 0], [1, 0], [0, -1], [0, 1]]
HEIGHT = map.size
WIDTH = map[0].size

def find_neighbours(position, map, regions, region)
  x,y = position
  v = map[x][y]
  return false if regions[x][y] != -1
  regions[x][y] = region
  DIR.each do |dx, dy|
    nx, ny = x + dx, y + dy
    if nx >= 0 && nx < HEIGHT && ny >= 0 && ny < WIDTH
      if map[nx][ny] == v
        find_neighbours([nx, ny], map, regions, region)
      end
    end
  end
  true
end

regions = Array.new(HEIGHT) { Array.new(WIDTH, -1) }
region = 0
regions.map.with_index do |row, i|
  row.map.with_index do |cell, j|
    region += 1 if find_neighbours([i,j], map,regions, region)
  end
end

def count_fences(position, map)
  x, y = position
  v = map[x][y]
  count = 4
  DIR.each do |dx, dy|
    nx, ny = x + dx, y + dy
    if nx >= 0 && nx < HEIGHT && ny >= 0 && ny < WIDTH
      count = count - 1 if map[nx][ny] == v
    end
  end
  count
end


area = {}
perimeter = {}
regions.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    v = regions[i][j]
    area[v] = 0 if area[v].nil?
    perimeter[v] = 0 if perimeter[v].nil?
    perimeter[v] += count_fences([i, j], regions)
    area[v] += 1
  end
end

price = 0
area.each do |key, area|
  price += area * perimeter[key]
end
p perimeter
p area
p price
