array = [2,4,1,5,7,5,0,3,4,0,1,6,5,5,3,0]
order = array.reverse

number=0

order.each do |a|
  number = (number + a) * 8
end

p number
p number/8
