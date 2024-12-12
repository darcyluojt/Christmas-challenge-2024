
# file_name = "./12-1.txt"
# content = File.read(file_name)

content = "EEEEE
EXXXX
EEEEE
EXXXX
EEEEE"
map = content.split("\n").map { |row| row.split('') }
DIR = [[-1, 0], [1, 0], [0, -1], [0, 1]]
HEIGHT = map.size
WIDTH = map[0].size
SIDES = {}
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

regions.each do |row|
  p row
end

def count_fences(position, map)
  x, y = position
  v = map[x][y]
  DIR.each do |dx, dy|
    nx, ny = x + dx, y + dy
    if nx >= 0 && nx < HEIGHT && ny >= 0 && ny < WIDTH
      if map[nx][ny] == v
        key = [v]
        SIDES[key] = [] if SIDES[key].nil?
        SIDES[key] << [nx, ny]
      end
    end
  end
  SIDES
end


area = {}
regions.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    v = regions[i][j]
    area[v] = 0 if area[v].nil?
    area[v] += 1
    count_fences([i, j], regions)
  end
end

def count_sides(values)
  hor = {}
  ver = {}
  sides = 0
  values.each do |x, y|
    hor[x] << y
    ver[y] << x
  end
  p hor
  p ver
  hor.each do |x, dots|
    dots.sort!
    if dots.size == 1
    dots.

end

SIDES.each do |key, values|

  p "#{key} => #{value.uniq}"
end

  # price = 0
  # area.each do |key, area|
  #   price += area * perimeter[key]
  # end
  # p perimeter
  # p area
  # p price
