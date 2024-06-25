require_relative '../modules/manufacturer'
require_relative '../modules/instance_counter'
require_relative '../modules/validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  # Class methods
  @@all_trains = []

  class << self
    def all
      @@all_trains
    end

    def find(number)
      @@all_trains.find { |train| train.number == number }
    end
  end

  # Instance methods
  attr_reader :number, :type, :route, :current_station_index, :speed, :wagons

  VALID_TYPES = %i[psg crg].freeze
  NUMBER_FORMAT = /^TR-[CP]\d{2}$/i.freeze

  def initialize(type, number, wagons = 0)
    @type = type
    @number = number
    @wagons_qty = wagons
    validate!
    @name = number
    @speed = 0
    @wagons = Array.new(wagons_qty.to_i) { init_wagons }
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

  attr_reader :wagons_qty

  def init_wagons
    case type
    when :psg then PassengerWagon.new
    when :crg then CargoWagon.new
    end
  end

  def validate!
    errors = []

    errors << 'Type of the train has an invalid format.' unless VALID_TYPES.include?(type)
    errors << 'Train number has invalid format.' if number !~ NUMBER_FORMAT
    errors << 'Train number is not unique.' if self.class.find(number)
    errors << 'Quantity of wagons entered incorrectly.' if wagons_qty.to_s !~ /\A(0|[1-9]\d*)\z/

    raise errors.join("\n") unless errors.empty?
  end
end
