# Класс Train (Поезд):
# + Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные
# указываются при создании экземпляра класса.
# + Может набирать скорость.
# + Может возвращать текущую скорость.
# + Может тормозить (сбрасывать скорость до нуля).
# + Может возвращать количество вагонов.
# + Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или
# уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не
# движется.
# + Может принимать маршрут следования (объект класса Route).
# + При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# + Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад,
# но только на 1 станцию за раз.
# + Возвращать предыдущую станцию, текущую, следующую, на основе маршрута.

require_relative 'Station'
require_relative 'Route'

class Train
  attr_reader :number, :type
  attr_accessor :speed, :wagons, :route, :current_station, :current_station_i

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @route = nil
    @current_station_i = 0
  end

  def accelerate(speed)
    self.speed += speed
  end

  def current_speed
    self.speed
  end

  def brake
    self.speed = 0
  end

  def wagons_count
    wagons
  end

  def add_wagon
    return if self.speed > 0

    self.wagons += 1
  end

  def remove_wagon
    return if self.speed > 0 || self.wagons.zero?

    self.wagons -= 1
  end

  def set_route(route)
    # передаю путь переменной экземпляра поезда:
    self.route = route
    # назначаю индекс текущей станции:
    self.current_station_i = 0
    # получаю текущую станцию из полученного пути:
    self.current_station = route.stations.first
    # вызываю текущую станцию и передаю в нее поезд:
    current_station.accept_train(self)
  end

  def move_forward
    return unless next_station # если нет следующей станции, выходим

    current_station.send_train(self)
    self.current_station_i += 1
    self.current_station = route.stations[self.current_station_i]
    current_station.accept_train(self)
  end

  def move_backward
    return unless previous_station

    current_station.send_train(self)
    self.current_station_i -= 1
    self.current_station = route.stations[self.current_station_i]
    current_station.accept_train(self)
  end

  def previous_station
    return if self.current_station_i.zero?

    route.stations[self.current_station_i - 1]
  end

  def current_station
    route.stations[self.current_station_i]
  end

  def next_station
    route.stations[@current_station_i + 1]
  end
end