def run_programme(programme,a,b,c)
  output = []
  pointer = 0
  while pointer < programme.size
    opcode = programme[pointer]
    operand = programme[pointer + 1]

    break if operand.nil?

    combo_operand = case operand
    when 4 then a
    when 5 then b
    when 6 then c
    else operand
    end
    case opcode
    when 0 # combo
      a = a / (2**combo_operand)
    when 1 # literal
      b ^= operand
    when 2 # combo
      b = combo_operand % 8
    when 3 # literal
      if a != 0
        pointer = operand  # Jump to new instruction
        next
      end
    when 4
      b ^= c
    when 5 # combo
      output << combo_operand % 8
    when 6 # combo
      b = a / 2**combo_operand
    when 7 # combo
      c = a / 2**combo_operand
    end
    pointer += 2
  end
  output
end

# start = Time.now
# p result = run_programme(programme,a,b,c).join(',')
# ending = Time.now
# puts "Time elapsed #{ending - start} seconds"

# --- Part Two ---
start = Time.now


programme = [2,4,1,5,7,5,0,3,4,0,1,6,5,5,3,0]
# programme = [0,3,5,4,3,0]
for i in 105553116266496..105553116266496*5
  a = i
  b = 0
  c = 0
  p "Trying with a = #{a}"
  break if run_programme(programme,a,b,c) == programme
end
ending = Time.now
puts "Time elapsed #{ending - start} seconds"

# potential_a.each do |a|
#   b = 0
#   c = 0
#   puts "Trying with a = #{a}"
#   p result = run_programme(programme,a,b,c)
#   puts result == programme
# end
# ending = Time.now
# puts "Time elapsed #{ending - start} seconds"
