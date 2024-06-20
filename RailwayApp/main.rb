## Создать модуль, который позволит указывать название компании-производителя и получать его. Подключить модуль
## к классам Вагон и Поезд.
## В классе Station (жд станция) создать метод класса all, который возвращает все станции (объекты), созданные
## на данный момент
## Добавить к поезду атрибут Номер (произвольная строка), если его еще нет, который указыватеся при его создании
## В классе Train создать метод класса find, который принимает номер поезда (указанный при его создании) и возвращает
## объект поезда по номеру или nil, если поезд с таким номером не найден.

## Создать модуль InstanceCounter, содержащий следующие методы класса и инстанс-методы, которые подключаются
## автоматически при вызове include в классе:
## Методы класса:
##        - instances, который возвращает кол-во экземпляров данного класса
## Инстанс-методы:
##        - register_instance, который увеличивает счетчик кол-ва экземпляров класса и который можно вызвать из
##        конструктора. При этом данный метод не должен быть публичным.
## Подключить этот модуль в классы поезда, маршрута и станции.
## Примечание: инстансы подклассов могут считаться по отдельности, не увеличивая счетчик инстансов базового класса.

# frozen_string_literal: true

require 'require_all'
require_all 'lib'
require 'pry'

def get_index_by_name(word, array)
  array.index { |item| item.name == word }
end

Station.new('Tln')
Station.new('Msk')
Station.new('Ekb')
Station.new('Spb')
Station.new('Kzn')
Station.new('Vdv')
Station.new('Sci')
Station.new('Arh')

routes = []
routes << Route.new(Station.all[0], Station.all[5])
routes << Route.new(Station.all[7], Station.all[6])
routes << Route.new(Station.all[3], Station.all[4])

PassengerTrain.new('TR-P1', 5)
CargoTrain.new('TR-C1', 10)
PassengerTrain.new('TR-P2', 7)

Train.all[0].route = routes[0]
Train.all[1].route = routes[1]
Train.all[2].route = routes[2]

# loop do
#   puts "\n*************************************************************************************************************"
#   puts "Insert 'exit' to leave the program."
#   puts "Insert 'cs' / 'ct' / 'cr' to create: station / train / route."
#   puts "Insert 'ir' / 'dr' to increase / decrease a route."
#   puts "Insert 'sr' to set route for a train."
#   puts "Insert 'tf' / 'tb' to to move train forward / backward."
#   puts "Insert 'aw' / 'rw' to add / remove wagon on a train."
#   puts "Insert 'ls' to show the list of stations and trains based on them."

#   command = gets.chomp.downcase

#   case command
#   when 'cs'
#     print 'Available stations: '
#     Station.all.each { |station| print "#{station.name} | " }
#     print "\nEnter new station name: "
#     name = gets.chomp.capitalize
#     Station.all << Station.new(name)
#     Station.all.sort_by! { |station| station.name }
#     print 'Station list updated: '
#     Station.all.each { |station| print "#{station.name} | " }

#   when 'ct'
#     print 'Existed trains: '
#     Train.all_trains.each { |train| print "#{train.number} | " }
#     print "\nEnter the new train number: "
#     number = gets.chomp.upcase
#     print "Type 'c' or 'p' for Cargo or Passenger: "
#     type = gets.chomp.downcase
#     if %w[c p].include?(type) == false
#       puts 'Invalid type'
#       break
#     end
#     print 'Enter the quantity of wagons: '
#     wagons_qty = gets.chomp.to_i

#     Train.all_trains << (type == 'c' ? CargoTrain.new(number, wagons_qty) : PassengerTrain.new(number, wagons_qty))
#     Train.all_trains.sort_by! { |train| train.number }
#     print 'Train list updated: '
#     Train.all_trains.each { |train| print "#{train.number} | " }

#   when 'cr'
#     print 'Available stations: '
#     Station.all.each { |station| print "#{station.name} | " }
#     print "\nEnter departure station from the list: "
#     departure = gets.chomp.capitalize
#     print 'Enter arrival station: '
#     arrival = gets.chomp.capitalize
#     routes << Route.new(Station.all[get_index_by_name(departure, stations)],
#                         Station.all[get_index_by_name(arrival, stations)])
#     routes.sort_by! { |route| route.name }
#     print 'Route list updated: '
#     routes.each { |route| print "#{route.name} | " }

#   when 'ir'
#     puts 'Here is the list of existing routes: '
#     routes.each_with_index do |route, index|
#       puts "#{index + 1}. From - To: #{route.name}. List of stations:"
#       route.display_stations
#     end
#     print 'Enter the order number of the route: '
#     route_index = gets.chomp.to_i - 1
#     print 'Available stations: '
#     Station.all.each { |station| print "#{station.name} | " }
#     print "\nEnter the station name from the list to add: "
#     station_to_add = gets.chomp.capitalize
#     routes[route_index].add_station(Station.all[get_index_by_name(station_to_add, Station.all)])
#     puts 'Route updated: '
#     routes[route_index].display_stations

#   when 'dr'
#     puts 'Here is the list of existing routes: '
#     routes.each_with_index do |route, index|
#       puts "#{index + 1}. From - To: #{route.name}. List of stations:"
#       route.display_stations
#     end
#     print 'Enter the order number of the route to delete station: '
#     route_index = gets.chomp.to_i - 1
#     # print 'Available stations: '
#     # Station.all.each { |station| print "#{station.name} " }
#     print 'Enter the station name from the rote to remove: '
#     station_to_remove = gets.chomp.capitalize
#     routes[route_index].remove_station(Station.all[get_index_by_name(station_to_remove, Station.all)])
#     puts 'Route updated: '
#     routes[route_index].display_stations

#   when 'sr'
#     puts 'Existed trains: '
#     Train.all_trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number} " }
#     puts 'Existed routes: '
#     routes.each_with_index do |route, index|
#       puts "#{index + 1}. From - To: #{route.name}. List of stations:"
#       route.display_stations
#     end
#     print 'Enter the order number of the train: '
#     train_index = gets.chomp.to_i - 1
#     print 'Enter the order number of the route: '
#     route_index = gets.chomp.to_i - 1
#     Train.all_trains[train_index].route = routes[route_index]
#     puts "Now train #{Train.all_trains[train_index].number} is set to route #{routes[route_index].name}"

#   when 'tf'
#     puts 'List of trains on the route: '
#     Train.all_trains.each_with_index do |train, index|
#       next unless train.route

#       puts "#{index + 1}. #{train.number}. Current: #{train.current_station.name}. On the route:"
#       train.route.display_stations
#     end
#     print 'Enter the order number of the train to move forward: '
#     train_index = gets.chomp.to_i - 1
#     Train.all_trains[train_index].move_forward
#     puts "Train #{Train.all_trains[train_index].number} moved to the station #{Train.all_trains[train_index].current_station.name}"

#   when 'tb'
#     puts 'List of trains on the route: '
#     Train.all_trains.each_with_index do |train, index|
#       next unless train.route

#       puts "#{index + 1}. #{train.number}. Current: #{train.current_station.name}. On the route:"
#       train.route.display_stations
#     end
#     print 'Enter the order number of the train to move backward: '
#     train_index = gets.chomp.to_i - 1
#     Train.all_trains[train_index].move_backward
#     puts "Train #{Train.all_trains[train_index].number} returned to the station #{Train.all_trains[train_index].current_station.name}"

#   when 'aw'
#     puts 'List of trains: '
#     Train.all_trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}. QTY of wagons: #{train.wagons.size}" }
#     puts 'Enter the order number of the train to add wagon: '
#     train_index = gets.chomp.to_i - 1
#     Train.all_trains[train_index].speed.zero? ? Train.all_trains[train_index].add_wagon : (puts 'Train is moving. Stop it first.')
#     puts "Train #{Train.all_trains[train_index].number} now has #{Train.all_trains[train_index].wagons.size} wagons."

#   when 'rw'
#     puts 'List of trains: '
#     Train.all_trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}. QTY of wagons: #{train.wagons.size}" }
#     puts 'Enter the order number of the train to remove wagon: '
#     train_index = gets.chomp.to_i - 1
#     Train.all_trains[train_index].speed.zero? ? Train.all_trains[train_index].remove_wagon : (puts 'Train is moving. Stop it first.')
#     puts "Train #{Train.all_trains[train_index].number} now has #{Train.all_trains[train_index].wagons.size} wagons."

#   when 'ls'
#     print 'Full list of stations: '
#     Station.all.each { |station| print "#{station.name} | " }
#     print "\nList of stations with trains on them: "
#     Station.all.each_with_index do |station, index|
#       next if station.trains.empty?

#       print "#{index + 1}. #{station.name} | "
#     end
#     print "\nEnter the order number of the station to see the list of trains: "
#     station_index = gets.chomp.to_i - 1
#     puts "Trains on the station #{Station.all[station_index].name}:"
#     Station.all[station_index].list_trains

#   when 'exit'
#     break

#   else
#     puts 'Invalid command'
#   end
# end
binding.pry
