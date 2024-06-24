## Реализовать проверку (валидацию) данных для всех классов. Проверять основные атрибуты (название, номер, тип и т.п.) на
## наличие, длину и т.п. (в зависимости от атрибута):
##       - Валидация должна вызываться при создании объекта, если объект невалидный, то должно выбрасываться исключение
##       - Должен быть метод valid? который возвращает true, если объект валидный и false - в противном случае.
## Релизовать проверку на формат номера поезда. Допустимый формат: три буквы или цифры в любом порядке, необязательный
## дефис (может быть, а может нет) и еще 2 буквы или цифры после дефиса.
## Убрать из классов все puts (кроме методов, которые и должны что-то выводить на экран), методы просто возвращают значения.
## (Начинаем бороться за чистоту кода).
## Релизовать простой текстовый интерфейс для создания поездов (если у вас уже реализован интерфейс, то дополнить его):
##     - Программа запрашивает у пользователя данные для создания поезда (номер и другие необходимые атрибуты)
##     - Если атрибуты валидные, то выводим информацию о том, что создан такой-то поезд
##      - Если введенные данные невалидные, то программа должна вывести сообщение о возникших ошибках и заново запросить
##      данные у пользователя. Реализовать это через механизм обработки исключений.

# frozen_string_literal: true

require_relative 'seeds'
require 'require_all'
require_all 'lib'
require 'pry'

def get_index_by_name(word, array)
  array.index { |item| item.name == word }
end

# binding.pry
loop do
  puts "\n*************************************************************************************************************"
  puts "Type 'exit'           to LEAVE the program."
  puts "Type 'cs'/'ct'/'cr'   to CREATE a STATION, TRAIN, or ROUTE."
  puts "Type 'ir'/'dr'        to INCREASE or DECREASE a ROUTE."
  puts "Type 'sr'             to SET a ROUTE for a train."
  puts "Type 'tf'/'tb'        to move a TRAIN FORWARD or BACKWARD."
  puts "Type 'aw'/'rw'        to ADD or REMOVE a WAGON from a train."
  puts "Type 'ls'             to show the LIST of STATIONS and the trains located at them."

  command = gets.chomp.downcase

  case command
  when 'cs'
    print 'Available stations: '
    Station.all_stations.each { |station| print "#{station.name} | " }
    print "\nEnter new station name: "
    name = gets.chomp.capitalize
    Station.new(name)
    # Station.all_stations.sort_by! { |station| station.name }
    Station.all_stations.sort_by!(&:name)
    print 'Station list updated: | '
    Station.all_stations.each { |station| print "#{station.name} | " }

  when 'ct'
    begin
      print 'Existing trains: | '
      Train.all_trains.each { |train| print "#{train.number} | " }
      print "\nEnter a two-digit value for the new train number, starting with 'TR-C##' for Cargo or 'TR-P##' for Passenger: "
      number = gets.chomp.upcase

      print 'Enter the quantity of wagons: '
      wagons_qty = gets.chomp
      number[3] == 'C' ? CargoTrain.new(number, wagons_qty) : PassengerTrain.new(number, wagons_qty)
    rescue RuntimeError => e
      puts "\nOops! Something went wrong: #{e.message}\n      Please try again!\n\n"
      retry
    end
    print "New train #{Train.all_trains.last.number}"
    Train.all_trains.sort_by!(&:number)
    print ' is added to the list: | '
    Train.all_trains.each { |train| print "#{train.number} | " }

  when 'cr'
    print 'Available stations: '
    Station.all_stations.each { |station| print "#{station.name} | " }
    print "\nEnter departure station from the list: "
    departure = gets.chomp.capitalize
    print 'Enter arrival station: '
    arrival = gets.chomp.capitalize
    Route.new(Station.all_stations[get_index_by_name(departure, stations)],
              Station.all_stations[get_index_by_name(arrival, stations)])
    # Route.all_routes.sort_by! { |route| route.name }
    Route.all_routes.sort_by!(&:name)
    print 'Route list updated: | '
    Route.all_routes.each { |route| print "#{route.name} | " }

  when 'ir'
    puts 'Here is the list of existing routes: '
    Route.all_routes.each_with_index do |route, index|
      puts "#{index + 1}. From - To: #{route.name}. List of stations:"
      route.display_stations
    end
    print 'Enter the order number of the route: '
    route_index = gets.chomp.to_i - 1
    print 'Available stations: | '
    Station.all_stations.each { |station| print "#{station.name} | " }
    print "\nEnter the station name from the list to add: "
    station_to_add = gets.chomp.capitalize
    Route.all_routes[route_index].add_station(Station.all_stations[get_index_by_name(station_to_add,
                                                                                     Station.all_stations)])
    puts 'Route updated: '
    Route.all_routes[route_index].display_stations

  when 'dr'
    puts 'Here is the list of existing routes: '
    Route.all_routes.each_with_index do |route, index|
      puts "#{index + 1}. From - To: #{route.name}. List of stations:"
      route.display_stations
    end
    print 'Enter the order number of the route to delete station: '
    route_index = gets.chomp.to_i - 1
    print 'Enter the station name from the rote to remove: '
    station_to_remove = gets.chomp.capitalize
    Route.all_routes[route_index].remove_station(Station.all_stations[get_index_by_name(station_to_remove,
                                                                                        Station.all_stations)])
    puts 'Route updated: '
    Route.all_routes[route_index].display_stations

  when 'sr'
    puts 'Existing trains: '
    Train.all_trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number} " }
    puts 'Existing routes: '
    Route.all_routes.each_with_index do |route, index|
      puts "#{index + 1}. From - To: #{route.name}. List of stations:"
      route.display_stations
    end
    print 'Enter the order number of the train: '
    train_index = gets.chomp.to_i - 1
    print 'Enter the order number of the route: '
    route_index = gets.chomp.to_i - 1
    Train.all_trains[train_index].route = Route.all_routes[route_index]
    puts "Now train #{Train.all_trains[train_index].number} is set to route #{routes[route_index].name}"

  when 'tf'
    puts 'List of trains on the route: '
    Train.all_trains.each_with_index do |train, index|
      next unless train.route

      puts "#{index + 1}. #{train.number}. Current: #{train.current_station.name}. On the route:"
      train.route.display_stations
    end
    print 'Enter the order number of the train to move forward: '
    train_index = gets.chomp.to_i - 1
    Train.all_trains[train_index].move_forward
    puts "Train #{Train.all_trains[train_index].number} moved to the station" \
         "#{Train.all_trains[train_index].current_station.name}"

  when 'tb'
    puts 'List of trains on the route: '
    Train.all_trains.each_with_index do |train, index|
      next unless train.route

      puts "#{index + 1}. #{train.number}. Current: #{train.current_station.name}. On the route:"
      train.route.display_stations
    end
    print 'Enter the order number of the train to move backward: '
    train_index = gets.chomp.to_i - 1
    Train.all_trains[train_index].move_backward
    puts "Train #{Train.all_trains[train_index].number} returned to the station" \
         "#{Train.all_trains[train_index].current_station.name}"

  when 'aw'
    puts 'List of trains: '
    Train.all_trains.each_with_index do |train, index|
      puts "#{index + 1}. #{train.number}. QTY of wagons: #{train.wagons.size}"
    end
    puts 'Enter the order number of the train to add wagon: '
    train_index = gets.chomp.to_i - 1
    Train.all_trains[train_index].speed.zero? ? Train.all_trains[train_index].add_wagon : (puts 'Stop the train first.')
    puts "Train #{Train.all_trains[train_index].number} now has #{Train.all_trains[train_index].wagons.size} wagons."

  when 'rw'
    puts 'List of trains: '
    Train.all_trains.each_with_index do |train, index|
      puts "#{index + 1}. #{train.number}. QTY of wagons: #{train.wagons.size}"
    end
    puts 'Enter the order number of the train to remove wagon: '
    train_index = gets.chomp.to_i - 1
    Train.all_trains[train_index].speed.zero? ? Train.all_trains[train_index].remove_wagon : (puts 'Stop the train first.')
    puts "Train #{Train.all_trains[train_index].number} now has #{Train.all_trains[train_index].wagons.size} wagons."

  when 'ls'
    print 'Full list of stations: | '
    Station.all_stations.each { |station| print "#{station.name} | " }
    print "\nList of stations with trains on them: | "
    Station.all_stations.each_with_index do |station, index|
      next if station.trains.empty?

      print "#{index + 1}. #{station.name} | "
    end
    print "\nEnter the order number of the station to see the list of trains: "
    station_index = gets.chomp.to_i - 1
    puts "Trains on the station #{Station.all_stations[station_index].name}:"
    Station.all_stations[station_index].list_trains

  when 'exit'
    break

  else
    puts 'Invalid command'
  end
end
