# Разбить программу на отдельные классы (каждый класс в отдельном файле)
# Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, который будет содержать общие
# методы и свойства
# Определить, какие методы могут быть помещены в private/protected и вынести их в такую секцию. В комментарии к методу
# обосновать, почему он был вынесен в private/protected
# Вагоны теперь делятся на грузовые и пассажирские (отдельные классы). К пассажирскому поезду можно прицепить только
# пассажирские, к грузовому - грузовые.
# При добавлении вагона к поезду, объект вагона должен передаваться как аргумент метода и сохраняться во внутреннем
# массиве поезда, в отличие от предыдущего задания, где мы считали только кол-во вагонов. Параметр конструктора "кол-во
# вагонов" при этом можно удалить.

# Добавить текстовый интерфейс:

# Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
#      - Создавать станции
#      - Создавать поезда
#      - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
#      - Назначать маршрут поезду
#      - Добавлять вагоны к поезду
#      - Отцеплять вагоны от поезда
#      - Перемещать поезд по маршруту вперед и назад
#      - Просматривать список станций и список поездов на станции

# frozen_string_literal: true

require_relative 'train'
require_relative 'station'
require_relative 'route'

require 'pry'

st_klg = Station.new(:klg)
st_vln = Station.new(:vln)
st_mns = Station.new(:mns)
st_kzn = Station.new(:kzn)
st_ekb = Station.new(:ekb)
st_omk = Station.new(:omk)
st_nsb = Station.new(:nsb)
st_irk = Station.new(:irk)
st_hbr = Station.new(:hbr)
st_vdv = Station.new(:vdv)

st_msk = Station.new(:msk)

st_arh = Station.new(:arh)
st_vld = Station.new(:vld)
st_yar = Station.new(:yar)
st_tla = Station.new(:tla)
st_orl = Station.new(:orl)
st_krs = Station.new(:krs)
st_rnd = Station.new(:rnd)
st_knd = Station.new(:knd)
st_sci = Station.new(:sci)

route_1 = Route.new(st_klg, st_vdv)
route_1.add_station(st_msk)

train_1 = Train.new('TRN-1', :crg, 20)
train_1.set_route(route_1)
train_1.move_forward

binding.pry
