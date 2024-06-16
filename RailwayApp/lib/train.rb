# frozen_string_literal: true

class Train
  attr_reader :number, :type, :route, :current_station_index, :speed, :wagons

  def initialize(type, number, wagons = 0)
    @number = number
    @name = number
    @type = type
    @speed = 0
    @wagons = Array.new(wagons) { init_wagons }
    @route = nil
    @current_station_index = 0
  end

  def remove_wagon
    wagons.pop if wagons.any? && speed.zero?
  end

  def accelerate(value)
    @speed += value
  end

  def brake
    @speed = 0
  end

  def route=(route)
    @route = route
    @current_station_index = 0
    current_station.accept_train(self)
  end

  def move_forward
    return unless next_station

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

  def current_station
    route.stations[current_station_index]
  end

  def next_station
    route.stations[current_station_index + 1]
  end

  private

  # Этот метод работает при инициализации поезда и публичным не должен быть по определению.
  def init_wagons
    return unless speed.zero?

    case type
    when :psg then PassengerWagon.new
    when :crg then CargoWagon.new
    end
  end
end
