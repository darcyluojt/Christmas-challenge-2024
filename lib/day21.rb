keyboard = [
  ['7','8','9'],
  ['4','5','6'],
  ['1','2','3'],
  [nil,'0','A']]

keys = [
  [nil,[-1,0],'A'],
  [[0,-1],[1,0],[0,1]]]
codes = ["480A","965A","140A","341A","285A"]
# codes = ["029A","980A","179A","456A","379A"]
def find_key(keyboard, code)
  keyboard.each_with_index do |row, i|
    row.each_with_index do |key, j|
      return [i,j] if key == code
    end
  end
end

def return_steps (vectors, keyboard)
  directions = [[1,0],[0,1],[-1,0],[0,-1]]
  steps = []
  original_position = find_key(keyboard, 'A')
  vectors.each do |vector|
    x,y = vector
    step = []
    # vertical move first
    unless y==0
      y.abs.times do
        step << [0,y/y.abs]
      end
    end
    vertical_move = [original_position[0], original_position[1] + y]
    unless x==0
      x.abs.times do
        step << [x/x.abs,0]
      end
    end
    horizontal_move = [vertical_move[0] + x, vertical_move[1]]
    nil_position = find_key(keyboard, nil)
    if nil_position == horizontal_move || nil_position == vertical_move
      steps << step.reverse
    else
      steps << step
    end
    p "step: #{step}; vector: #{vector}"
  end
  steps
end

def return_steps_robot (vectors, keyboard)
  directions = [[1,0],[0,1],[-1,0],[0,-1]]
  steps = []
  original_position = find_key(keyboard, 'A')
  vectors.each do |vector|
    x,y = vector
    step = []
    # vertical move first
    unless y==0
      y.abs.times do
        step << [0,y/y.abs]
      end
    end
    vertical_move = [original_position[0], original_position[1] + y]
    unless x==0
      x.abs.times do
        step << [x/x.abs,0]
      end
    end
    horizontal_move = [vertical_move[0] + x, vertical_move[1]]
    nil_position = find_key(keyboard, nil)
    if nil_position == horizontal_move || nil_position == vertical_move
      steps << step.reverse
    else
      steps << step
    end
  end
  steps
end

def draw_steps (steps)
  directions = {
    [1,0]=>'v',
    [0,1]=>'>',
    [-1,0]=>'^',
    [0,-1]=>'<'
}
  map = String.new
  steps.each do |step|
    if step == 'A'
      map += step
    else
      map += directions[step]
    end
  end
  map
end

p "---------first_robot--------"

first_distance = []
codes.each do |code|
  full = 'A' + code
  full = full.chars
  gap = []
  full.each_cons(2) do |a,b|
    row1, col1 = find_key(keyboard, a)
    row2, col2 = find_key(keyboard, b)
    gap << [row2-row1, col2-col1]
  end
  first_distance << gap
end

first_distance.each_with_index do |gap,i|
  p "#{codes[i]}: #{gap}"
end

first_steps = []
first_distance.each do |gap|
  first_steps << return_steps(gap, keyboard)
end

first_steps.each do |line|
  line[0].unshift('A')
  line.each do |step|
    step << 'A'
  end
  line.flatten!(1)
  p draw_steps(line)
end


p "---------second_robot--------"
diffs = []
first_steps.each do |line|
  diff = []
  line.each_cons(2) do |a,b|
    row1, col1 = find_key(keys, a)
    row2, col2 = find_key(keys, b)
    diff << [row2-row1, col2-col1]
  end
  diffs << diff
end

diffs.each do |code|
  p code
end

third_steps = []
diffs.each do |diff|
  third_steps << return_steps(diff,keys)
end

third_steps.map! do |line|
  line[0].unshift('A')
  line.each do |step|
    step << 'A'
  end
  line.flatten!(1)
end

third_steps.each do |line|
  p draw_steps(line)
end

third_level = []
third_steps.each do |line|
  diff = []
  line.each_cons(2) do |a,b|
    row1, col1 = find_key(keys, a)
    row2, col2 = find_key(keys, b)
    diff << [row2-row1, col2-col1]
  end
  third_level << diff
end

p "---------third_diff--------"
steps = []
third_level.each do |code|
  step = 0
  code.each do |a,b|
    step += a.abs + b.abs + 1
  end
  steps << step
end

result = 0
codes.each_with_index do |code, i|
  p "code: #{code}, steps: #{steps[i]}: mutiply: #{code.scan(/\d+/).first.to_i}; result: #{code.scan(/\d+/).first.to_i * steps[i]}"
  result += code.scan(/\d+/).first.to_i * steps[i]
end

p result







# >A ---A A
# <vA ---v 6
# A  ---v 3
# A ---v A
# >^A --A A
# level 3: <vA<AA>>^A vAA<^A>A<v<A>>^AvA^A<vA>^A<v<A>^A>AAvA^A<v<A>A>^AAAvA<^A>A"


# "A<A^A>^^AvvvA"
# "A^^^A<AvvvA>A"
# "A<<^A^^A>>AvvvA"
# "A<<^^A>A>AvvA"
# "A^A<<^^A>>AvvvA"


# <vA<AA>>^AvAA<^A>A<v<A>>^AvA^A<vA>^A<v<A>^A>AAvA^A<v<A>A>^AAAvA<^A>A
# v<<A>>^A<A>AvA<^AA>A<vAAA>^A
# <A^A>^^AvvvA

# +---+---+---+
# | 7 | 8 | 9 |
# +---+---+---+
# | 4 | 5 | 6 |
# +---+---+---+
# | 1 | 2 | 3 |
# +---+---+---+
#     | 0 | A |
#     +---+---+

  # buttons = ['A']
  # vectors.each do |vector|
  #   buttons << vector
  #   buttons << 'A'
  # end
  # vectors.unshift('A')
#     +---+---+
#     | ^ | A |
# +---+---+---+
# | < | v | > |
# +---+---+---+
