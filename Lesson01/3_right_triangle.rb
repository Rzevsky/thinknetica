print "Triangle side A: "
side_a = gets.chomp.to_f
print "Triangle side B: "
side_b = gets.chomp.to_f
print "Triangle side C: "
side_c = gets.chomp.to_f

sides = [side_a, side_b, side_c].sort

puts "This is a right triangle" if sides[0]**2 + sides[1]**2 == sides[2]**2

if side_a == side_b && side_b == side_c
  puts "This is a equilateral (and eisosceles) triangle (3 sides are equal)"
elsif side_a == side_b || side_b == side_c || side_c == side_a
  puts "This is a eisosceles triangle (2 sides are equal)"
end
