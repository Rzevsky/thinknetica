# frozen_string_literal: true

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

class Train
  attr_reader :number, :type, :route, :current_station_index, :speed, :wagons

  def initialize(number, type, wagons)
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

  def current_speed
    speed
  end

  def brake
    @speed = 0
  end

  def wagons_count
    wagons
  end

  def add_wagon
    return if speed.positive?

    self.wagons += 1
  end

  def remove_wagon
    return if speed.positive? || wagons.zero?

    self.wagons -= 1
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
