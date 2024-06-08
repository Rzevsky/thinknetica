# Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного
# товара (может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех
# пор, пока не введет "стоп" в качестве названия товара. На основе введенных данных требуетеся:
# - Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
# а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара.
# Также вывести итоговую сумму за каждый товар.
# - Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

purchases = {}
loop do
  print "Enter the good name or 'stop': "
  item = gets.chomp.to_sym
  break if item == :stop
  print "Enter the price for the unit: "
  price = gets.chomp.to_f
  print "Enter the quantity of the good: "
  quantity = gets.chomp.to_f

  purchases[item] = { price: price, quantity: quantity }
end

puts '---------------------'
purchases.each { |item, data| puts "#{item} - #{data}" }
puts '---------------------'
puts 'Goods - full price:'
purchases.each { |item, data| puts "#{item} - #{data[:price] * data[:quantity]}" }
puts '---------------------'
puts "Total price: #{purchases.values.sum { |data| data[:price] * data[:quantity] }}"
