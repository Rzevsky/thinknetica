def triangle_area(base, height)
  0.5 * base * height
end

print 'Insert the base of the triangle, please: '
tr_base = gets.chomp.to_f
print 'Insert the height of the triangle, please: '
tr_height = gets.chomp.to_f
puts "The area of the triangle is: #{triangle_area(tr_base, tr_height)}"
