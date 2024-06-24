require 'require_all'
require_all 'lib'

Station.new('Tln')
Station.new('Msk')
Station.new('Ekb')
Station.new('Spb')
Station.new('Kzn')
Station.new('Vdv')
Station.new('Sci')
Station.new('Arh')

Route.new(Station.all_stations[0], Station.all_stations[5])
Route.new(Station.all_stations[7], Station.all_stations[6])
Route.new(Station.all_stations[3], Station.all_stations[4])

CargoTrain.new('TR-C01', 10)
PassengerTrain.new('TR-P01', 5)
PassengerTrain.new('TR-P02', 7)

Train.all_trains[0].route = Route.all_routes[0]
Train.all_trains[1].route = Route.all_routes[1]
Train.all_trains[2].route = Route.all_routes[2]
