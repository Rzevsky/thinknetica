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
require 'pry'
require 'require_all'
require_all 'lib'

# binding.pry

def get_index_by_name(word, array)
  array.index { |item| item.name == word }
end

def create_station
  print 'Available stations: '
  Station.all.each { |station| print "#{station.name} | " }
  print "\nEnter new station name: "
  name = gets.chomp.capitalize
  Station.new(name)
  # Station.all.sort_by! { |station| station.name }
  Station.all.sort_by!(&:name)
  print 'Station list updated: | '
  Station.all.each { |station| print "#{station.name} | " }
end

def create_train
  begin
    print 'Existing trains: | '
    Train.all.each { |train| print "#{train.number} | " }
    print "\nEnter a two-digit value for the new train number, starting with 'TR-C##' for Cargo or 'TR-P##' for Passenger: "
    number = gets.chomp.upcase

    print 'Enter the quantity of wagons: '
    wagons_qty = gets.chomp
    number[3] == 'C' ? CargoTrain.new(number, wagons_qty) : PassengerTrain.new(number, wagons_qty)
  rescue RuntimeError => e
    puts "\nOops! Something went wrong:\n#{e.message}\nPlease try again!\n\n"
    retry
  end
  print "New train #{Train.all.last.number}"
  Train.all.sort_by!(&:number)
  print ' is added to the list: | '
  Train.all.each { |train| print "#{train.number} | " }
end

def create_route
  print 'Available stations: '
  Station.all.each { |station| print "#{station.name} | " }
  print "\nEnter departure station from the list: "
  departure = gets.chomp.capitalize
  print 'Enter arrival station: '
  arrival = gets.chomp.capitalize
  Route.new(Station.all[get_index_by_name(departure, Station.all)],
            Station.all[get_index_by_name(arrival, Station.all)])
  # Route.all.sort_by! { |route| route.name }
  Route.all.sort_by!(&:name)
  print 'Route list updated: | '
  Route.all.each { |route| print "#{route.name} | " }
end

def increase_route
  puts 'Here is the list of existing routes: '
  Route.all.each_with_index do |route, index|
    puts "#{index + 1}. From - To: #{route.name}. List of stations:"
    route.display_stations
  end
  print 'Enter the order number of the route: '
  route_index = gets.chomp.to_i - 1
  print 'Available stations: | '
  Station.all.each { |station| print "#{station.name} | " }
  print "\nEnter the station name from the list to add: "
  station_to_add = gets.chomp.capitalize
  Route.all[route_index].add_station(Station.all[get_index_by_name(station_to_add, Station.all)])
  puts 'Route updated: '
  Route.all[route_index].display_stations
end

def decrease_route
  puts 'Here is the list of existing routes: '
  Route.all.each_with_index do |route, index|
    puts "#{index + 1}. From - To: #{route.name}. List of stations:"
    route.display_stations
  end
  print 'Enter the order number of the route to delete station: '
  route_index = gets.chomp.to_i - 1
  print 'Enter the station name from the rote to remove: '
  station_to_remove = gets.chomp.capitalize
  Route.all[route_index].remove_station(Station.all[get_index_by_name(station_to_remove, Station.all)])
  puts 'Route updated: '
  Route.all[route_index].display_stations
end

def set_route
  puts 'Existing trains: '
  Train.all.each_with_index { |train, index| puts "#{index + 1}. #{train.number} " }
  puts 'Existing routes: '
  Route.all.each_with_index do |route, index|
    puts "#{index + 1}. From - To: #{route.name}. List of stations:"
    route.display_stations
  end
  print 'Enter the order number of the train: '
  train_index = gets.chomp.to_i - 1
  print 'Enter the order number of the route: '
  route_index = gets.chomp.to_i - 1
  Train.all[train_index].route = Route.all[route_index]
  puts "The train #{Train.all[train_index].number} is set to the route #{Route.all[route_index].name}"
end

def train_forward
  puts 'List of trains on the route: '
  Train.all.each_with_index do |train, index|
    next unless train.route

    puts "#{index + 1}. #{train.number}. Current: #{train.current_station.name}. On the route:"
    train.route.display_stations
  end
  print 'Enter the order number of the train to move forward: '
  train_index = gets.chomp.to_i - 1
  Train.all[train_index].move_forward
  puts "Train #{Train.all[train_index].number} moved to the station #{Train.all[train_index].current_station.name}"
end

def train_backward
  puts 'List of trains on the route: '
  Train.all.each_with_index do |train, index|
    next unless train.route

    puts "#{index + 1}. #{train.number}. Current: #{train.current_station.name}. On the route:"
    train.route.display_stations
  end
  print 'Enter the order number of the train to move backward: '
  train_index = gets.chomp.to_i - 1
  Train.all[train_index].move_backward
  puts "Train #{Train.all[train_index].number} returned to the station #{Train.all[train_index].current_station.name}"
end

def add_wagon
  puts 'List of trains: '
  Train.all.each_with_index do |train, index|
    puts "#{index + 1}. #{train.number}. QTY of wagons: #{train.wagons.size}"
  end
  puts 'Enter the order number of the train to add a wagon: '
  train_index = gets.chomp.to_i - 1
  Train.all[train_index].speed.zero? ? Train.all[train_index].add_wagon : (puts 'Stop the train first.')
  puts "The train #{Train.all[train_index].number} now has #{Train.all[train_index].wagons.size} wagons."
end

def remove_wagon
  puts 'List of trains: '
  Train.all.each_with_index do |train, index|
    puts "#{index + 1}. #{train.number}. QTY of wagons: #{train.wagons.size}"
  end
  puts 'Enter the order number of the train to remove a wagon: '
  train_index = gets.chomp.to_i - 1
  Train.all[train_index].speed.zero? ? Train.all[train_index].remove_wagon : (puts 'Stop the train first.')
  puts "The train #{Train.all[train_index].number} now has #{Train.all[train_index].wagons.size} wagons."
end

def list_stations
  print 'Full list of stations: | '
  Station.all.each { |station| print "#{station.name} | " }
  print "\nList of stations with trains on them: | "
  Station.all.each_with_index do |station, index|
    next if station.trains.empty?

    print "#{index + 1}. #{station.name} | "
  end
  print "\nEnter the order number of the station to see the list of trains: "
  station_index = gets.chomp.to_i - 1
  print "Trains on the station #{Station.all[station_index].name}: | "
  Station.all[station_index].list_trains.each { |train| print "#{train} | " }
end

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
  when 'cs' then create_station
  when 'ct' then create_train
  when 'cr' then create_route
  when 'ir' then increase_route
  when 'dr' then decrease_route
  when 'sr' then set_route
  when 'tf' then train_forward
  when 'tb' then train_backward
  when 'aw' then add_wagon
  when 'rw' then remove_wagon
  when 'ls' then list_stations
  when 'exit' then break
  else puts 'Invalid command'
  end
end
