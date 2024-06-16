# + Разбить программу на отдельные классы (каждый класс в отдельном файле)
# + Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, который будет содержать общие
# + методы и свойства
# + Определить, какие методы могут быть помещены в private/protected и вынести их в такую секцию. В комментарии к методу
# + обосновать, почему он был вынесен в private/protected
# + Вагоны теперь делятся на грузовые и пассажирские (отдельные классы). К пассажирскому поезду можно прицепить только
# + пассажирские, к грузовому - грузовые.
# + При добавлении вагона к поезду, объект вагона должен передаваться как аргумент метода и сохраняться во внутреннем
# + массиве поезда, в отличие от предыдущего задания, где мы считали только кол-во вагонов. Параметр конструктора "кол-во
# + вагонов" при этом можно удалить.

# Добавить текстовый интерфейс:

# + Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
# +     - Создавать станции
# +     - Создавать поезда
# +     - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
# +     - Назначать маршрут поезду
# +     - Добавлять вагоны к поезду
# +     - Отцеплять вагоны от поезда
# +     - Перемещать поезд по маршруту вперед и назад
# +     - Просматривать список станций и список поездов на станции

# frozen_string_literal: true

require_relative 'train'
require_relative 'wagon'
require_relative 'station'
require_relative 'route'

def get_index_by_name(word, array)
  array.index { |item| item.name == word }
end

stations = []
stations << Station.new('Tln')
stations << Station.new('Msk')
stations << Station.new('Ekb')
stations << Station.new('Spb')
stations << Station.new('Kzn')
stations << Station.new('Vdv')
stations << Station.new('Sci')
stations << Station.new('Arh')

routes = []
routes << Route.new(stations[0], stations[5])
routes << Route.new(stations[7], stations[6])
routes << Route.new(stations[3], stations[4])

trains = []
trains << PassengerTrain.new('TR-P1', 5)
trains << CargoTrain.new('TR-C1', 10)
trains << PassengerTrain.new('TR-P2', 7)

trains[0].route = routes[0]
trains[1].route = routes[1]
trains[2].route = routes[2]

loop do
  puts "\n*************************************************************************************************************"
  puts "Insert 'exit' to leave the program."
  puts "Insert 'cs' / 'ct' / 'cr' to create: station / train / route."
  puts "Insert 'ir' / 'dr' to increase / decrease a route."
  puts "Insert 'sr' to set route for a train."
  puts "Insert 'tf' / 'tb' to to move train forward / backward."
  puts "Insert 'aw' / 'rw' to add / remove wagon on a train."
  puts "Insert 'ls' to show the list of stations and trains based on them."

  command = gets.chomp.downcase

  case command
  when 'cs'
    print 'Available stations: '
    stations.each { |station| print "#{station.name} | " }
    print "\nEnter new station name: "
    name = gets.chomp.capitalize
    stations << Station.new(name)
    stations.sort_by! { |station| station.name }
    print 'Station list updated: '
    stations.each { |station| print "#{station.name} | " }

  when 'ct'
    print 'Existed trains: '
    trains.each { |train| print "#{train.number} | " }
    print "\nEnter the new train number: "
    number = gets.chomp.upcase
    print "Type 'c' or 'p' for Cargo or Passenger: "
    type = gets.chomp.downcase
    if %w[c p].include?(type) == false
      puts 'Invalid type'
      break
    end
    print 'Enter the quantity of wagons: '
    wagons_qty = gets.chomp.to_i

    trains << (type == 'c' ? CargoTrain.new(number, wagons_qty) : PassengerTrain.new(number, wagons_qty))
    trains.sort_by! { |train| train.number }
    print 'Train list updated: '
    trains.each { |train| print "#{train.number} | " }

  when 'cr'
    print 'Available stations: '
    stations.each { |station| print "#{station.name} | " }
    print "\nEnter departure station from the list: "
    departure = gets.chomp.capitalize
    print 'Enter arrival station: '
    arrival = gets.chomp.capitalize
    routes << Route.new(stations[get_index_by_name(departure, stations)],
                        stations[get_index_by_name(arrival, stations)])
    routes.sort_by! { |route| route.name }
    print 'Route list updated: '
    routes.each { |route| print "#{route.name} | " }

  when 'ir'
    puts 'Here is the list of existing routes: '
    routes.each_with_index do |route, index|
      puts "#{index + 1}. From - To: #{route.name}. List of stations:"
      route.display_stations
    end
    print 'Enter the order number of the route: '
    route_index = gets.chomp.to_i - 1
    print 'Available stations: '
    stations.each { |station| print "#{station.name} | " }
    print "\nEnter the station name from the list to add: "
    station_to_add = gets.chomp.capitalize
    routes[route_index].add_station(stations[get_index_by_name(station_to_add, stations)])
    puts 'Route updated: '
    routes[route_index].display_stations

  when 'dr'
    puts 'Here is the list of existing routes: '
    routes.each_with_index do |route, index|
      puts "#{index + 1}. From - To: #{route.name}. List of stations:"
      route.display_stations
    end
    print 'Enter the order number of the route to delete station: '
    route_index = gets.chomp.to_i - 1
    # print 'Available stations: '
    # stations.each { |station| print "#{station.name} " }
    print 'Enter the station name from the rote to remove: '
    station_to_remove = gets.chomp.capitalize
    routes[route_index].remove_station(stations[get_index_by_name(station_to_remove, stations)])
    puts 'Route updated: '
    routes[route_index].display_stations

  when 'sr'
    puts 'Existed trains: '
    trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number} " }
    puts 'Existed routes: '
    routes.each_with_index do |route, index|
      puts "#{index + 1}. From - To: #{route.name}. List of stations:"
      route.display_stations
    end
    print 'Enter the order number of the train: '
    train_index = gets.chomp.to_i - 1
    print 'Enter the order number of the route: '
    route_index = gets.chomp.to_i - 1
    trains[train_index].route = routes[route_index]
    puts "Now train #{trains[train_index].number} is set to route #{routes[route_index].name}"

  when 'tf'
    puts 'List of trains on the route: '
    trains.each_with_index do |train, index|
      next unless train.route

      puts "#{index + 1}. #{train.number}. Current: #{train.current_station.name}. On the route:"
      train.route.display_stations
    end
    print 'Enter the order number of the train to move forward: '
    train_index = gets.chomp.to_i - 1
    trains[train_index].move_forward
    puts "Train #{trains[train_index].number} moved to the station #{trains[train_index].current_station.name}"

  when 'tb'
    puts 'List of trains on the route: '
    trains.each_with_index do |train, index|
      next unless train.route

      puts "#{index + 1}. #{train.number}. Current: #{train.current_station.name}. On the route:"
      train.route.display_stations
    end
    print 'Enter the order number of the train to move backward: '
    train_index = gets.chomp.to_i - 1
    trains[train_index].move_backward
    puts "Train #{trains[train_index].number} returned to the station #{trains[train_index].current_station.name}"

  when 'aw'
    puts 'List of trains: '
    trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}. QTY of wagons: #{train.wagons.size}" }
    puts 'Enter the order number of the train to add wagon: '
    train_index = gets.chomp.to_i - 1
    trains[train_index].speed.zero? ? trains[train_index].add_wagon : (puts 'Train is moving. Stop it first.')
    puts "Train #{trains[train_index].number} now has #{trains[train_index].wagons.size} wagons."

  when 'rw'
    puts 'List of trains: '
    trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}. QTY of wagons: #{train.wagons.size}" }
    puts 'Enter the order number of the train to remove wagon: '
    train_index = gets.chomp.to_i - 1
    trains[train_index].speed.zero? ? trains[train_index].remove_wagon : (puts 'Train is moving. Stop it first.')
    puts "Train #{trains[train_index].number} now has #{trains[train_index].wagons.size} wagons."

  when 'ls'
    print 'Full list of stations: '
    stations.each { |station| print "#{station.name} | " }
    print "\nList of stations with trains on them: "
    stations.each_with_index do |station, index|
      next if station.trains.empty?

      print "#{index + 1}. #{station.name} | "
    end
    print "\nEnter the order number of the station to see the list of trains: "
    station_index = gets.chomp.to_i - 1
    puts "Trains on the station #{stations[station_index].name}:"
    stations[station_index].list_trains

  when 'exit'
    break

  else
    puts 'Invalid command'
  end
end

# require 'pry'
# binding.pry
