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

Route.new(Station.all[0], Station.all[5])
Route.new(Station.all[0], Station.all[6])
Route.new(Station.all[0], Station.all[4])

CargoTrain.new('TR-C01', 10)
PassengerTrain.new('TR-P01', 5)
PassengerTrain.new('TR-P02', 7)

Train.all[0].route = Route.all[0]
Train.all[1].route = Route.all[1]
Train.all[2].route = Route.all[2]
