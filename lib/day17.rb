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
      a >>= combo_operand
      # a = a / 2**combo_operand
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
      b = a >> combo_operand
    when 7 # combo
      c = a >> combo_operand
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
n_last_found = 0
# for i in 64980670000000..64980670000000 * 2
  a = 6498067000000
  b = 0
  c = 0
  p run_programme(programme,a,b,c)

  # # compute how many outputs match the programme:
  # n_equal = 0
  # p.each_with_index do |output, index|
  #   if output == programme[index]
  #     n_equal += 1
  #   else
  #     break
  #   end
  # end

  # if [2,4] == p
  #   puts "Found a match with a = #{a} and output = #{p}"
  # end

  # if n_equal > n_last_found
  #   n_last_found = n_equal
  #   a_binary_string = a.to_s(2)
  #   # 0 pad the binary string
  #   a_binary_string = "0" * (32 - a_binary_string.size) + a_binary_string
  #   puts "Found a better match with a = #{a_binary_string} = #{a} and output = #{p}"
  # end

ending = Time.now
puts "Time elapsed #{ending - start} seconds"

# puts run_programme(programme,46187030,0,0).join(',')

# potential_a.each do |a|
#   b = 0
#   c = 0
#   puts "Trying with a = #{a}"
#   p result = run_programme(programme,a,b,c)
#   puts result == programme
# end
# ending = Time.now
# puts "Time elapsed #{ending - start} seconds"
