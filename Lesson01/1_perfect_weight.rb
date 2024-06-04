def perfect_weight(height)
  (height - 110) * 1.15
end

print 'Insert your name, please: '
name = gets.chomp.capitalize
print 'Insert your weight, please: '
weight = gets.chomp.to_i
print 'Insert your height, please: '
height = gets.chomp.to_i

puts "#{name}, your optimal weight is #{perfect_weight(height)}"
puts "Your weight is optimal already" if perfect_weight(height) < 0
