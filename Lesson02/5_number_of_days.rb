#Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
#Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.
#(Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?)

def leap_year(year)
  year % 4 == 0 && year % 100 != 0 || year % 400 == 0 ? true : false
end

print 'Enter the date (dd.mm.yyyy): '
date = gets.chomp
day, month, year = date.split('.').map(&:to_i)

months = {
1 => 31,
2 => 28, # 29
3 => 31,
4 => 30,
5 => 31,
6 => 30,
7 => 31,
8 => 31,
9 => 30,
10 => 31,
11 => 30,
12 => 31
}
months[2] = 29 if leap_year(year)

days = months.select { |month_num, _| month_num < month }.values.sum + day
puts "Number of days are: #{days}."
