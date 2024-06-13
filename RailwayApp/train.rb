# frozen_string_literal: true

class Train
  attr_reader :number, :type, :route, :current_station_index, :speed, :wagons

  def initialize(number, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @route = nil
    @current_station_index = 0
  end

  def accelerate(value)
    @speed += value
  end

  def brake
    @speed = 0
  end

  def wagons_count
    wagons
  end

  def add_wagon
    return if speed.positive?

    @wagons += 1
  end

  def remove_wagon
    return if speed.positive? || wagons.zero?

    @wagons -= 1
  end

  def set_route(route)
    @route = route
    @current_station_index = 0

    # Сам себе объясняю:
    # Вызывается метод current_station, который возвращает текущую станцию (см. в ниже, в конце).
    # Т.е. тут вызывается метод accept_train подставленного экземпляра станции.
    # А параметром является экземпляр поезда (self):
    current_station.accept_train(self)
  end

  def move_forward
    return unless next_station # если нет следующей станции, выходим

    current_station.send_train(self)

    @current_station_index += 1
    current_station.accept_train(self)
  end

  def move_backward
    return unless previous_station

    current_station.send_train(self)
    @current_station_index -= 1
    current_station.accept_train(self)
  end

  def previous_station
    route.stations[current_station_index - 1]
  end

  # метод возвращает текущую СТАНЦИЮ (объект класса Station)
  def current_station
    route.stations[current_station_index]
  end

  def next_station
    route.stations[current_station_index + 1]
  end
end

class PassengerTrain < Train
  def initialize(number, wagons)
    super
    @type = :passenger
  end
end

#
class CargoTrain < Train
  def initialize(number, wagons)
    super
    @type = :cargo
  end
end
