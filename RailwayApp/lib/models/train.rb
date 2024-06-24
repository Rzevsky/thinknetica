require_relative '../modules/manufacturer'
require_relative '../modules/instance_counter'

class Train
  include InstanceCounter
  include Manufacturer

  # Class methods
  @@all_trains = []

  class << self
    def all_trains
      @@all_trains
    end

    def find(number)
      @@all_trains.find { |train| train.number == number }
    end
  end

  # Instance methods
  attr_reader :number, :type, :route, :current_station_index, :speed, :wagons

  NUMBER_FORMAT = /^TR-[CP]\d{2}$/i.freeze

  def initialize(type, number, wagons = 0)
    @wagons_qty = wagons
    @number = number
    validate!
    @name = number
    @type = type
    @speed = 0
    @wagons = Array.new(wagons_qty.to_i) { init_wagons }
    @route = nil
    @current_station_index = 0
    @@all_trains << self
    register_instance
  end

  def valid?
    validate!
  rescue RuntimeError
    false
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

  attr_reader :wagons_qty

  def init_wagons
    case type
    when :psg then PassengerWagon.new
    when :crg then CargoWagon.new
    end
  end

  def validate!
    raise 'Train number has invalid format.' if number !~ NUMBER_FORMAT
    raise 'Train number is not unique.' if self.class.find(number)
    # Специально не преобразовывал из String - чтобы поймать тут все, что введено. Так же по заданию?
    raise 'Quantity of wagons entered incorrectly.' if wagons_qty.to_s !~ /\A(0|[1-9]\d*)\z/
  end
end
