require_relative '../modules/manufacturer'
require_relative '../modules/instance_counter'

class Train
  include InstanceCounter
  include Manufacturer

  # Class methods
  @@all_trains = []

  def self.all
    @@all_trains
  end

  def self.find(number)
    @@all_trains.find { |train| train.number == number }
  end

  # Instance methods
  attr_reader :number, :type, :route, :current_station_index, :speed, :wagons

  def initialize(type, number, wagons = 0)
    @number = number
    @name = number
    @type = type
    @speed = 0
    @wagons = Array.new(wagons) { init_wagons }
    @route = nil
    @current_station_index = 0
    @@all_trains << self
    register_instance
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

  def init_wagons
    case type
    when :psg then PassengerWagon.new
    when :crg then CargoWagon.new
    end
  end
end
