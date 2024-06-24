require_relative '../modules/instance_counter'

class Station
  include InstanceCounter

  # Class methods
  @all_stations = []

  class << self
    attr_reader :all_stations

    # def all
    #   @all_stations
    # end
  end

  # Instance methods
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    self.class.all_stations << self
    register_instance
  end

  def accept_train(number)
    trains << number
  end

  def send_train(train)
    trains.delete(train)
  end

  def list_trains
    trains.each(&:number)
  end

  def list_trains_by_type(type)
    trains.select { |train| train.type == type }
  end
end
