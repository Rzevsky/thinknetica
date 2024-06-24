require_relative '../modules/instance_counter'

class Route
  include InstanceCounter

  # Class methods
  @all_routes = []

  class << self
    attr_reader :all_routes

    # def all
    #   @all_routes
    # end
  end

  # Instance methods
  attr_reader :stations, :name

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    @name = "#{start_station.name}-#{end_station.name}"
    self.class.all_routes << self
    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station) if station != stations.first && station != stations.last
  end

  def display_stations
    stations.each { |station| puts station.name }
    nil
  end
end
