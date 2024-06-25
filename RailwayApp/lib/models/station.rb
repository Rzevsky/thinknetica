require_relative '../modules/instance_counter'
require_relative '../modules/validation'

class Station
  include InstanceCounter
  include Validation

  # Class methods
  @all_stations = []

  class << self
    def all
      @all_stations
    end
  end

  # Instance methods
  attr_reader :name, :trains

  NAME_FORMAT = /^[a-z]{3}$/i.freeze

  def initialize(name)
    @name = name
    validate!
    @name.capitalize!
    @trains = []
    self.class.all << self
    register_instance
  end

  def accept_train(number)
    trains << number
  end

  def send_train(train)
    trains.delete(train)
  end

  def list_trains
    trains.map(&:number)
  end

  def list_trains_by_type(type)
    trains.select { |train| train.type == type }
  end

  private

  def validate!
    raise 'The station name has an invalid format.' if name !~ NAME_FORMAT
  end
end
