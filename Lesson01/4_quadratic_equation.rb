puts 'Enter the coefficients of the square equation a*x^2 + b*x + c = 0'
print "a = "
a = gets.chomp.to_f
print "b = "
b = gets.chomp.to_f
print "c = "
c = gets.chomp.to_f

d = b**2 - 4 * a * c

if d < 0
  puts "Discriminant = #{d}. No roots"
elsif d == 0
  x = -b / (2 * a)
  puts "Discriminant = 0. Root is: #{x}"
else
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)
  puts "Discriminant = #{d}. Roots are: #{x1} and #{x2}"
end
