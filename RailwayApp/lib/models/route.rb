require_relative '../modules/instance_counter'
require_relative '../modules/validation'

class Route
  include InstanceCounter
  include Validation

  # Class methods
  @all_routes = []

  class << self
    def all
      @all_routes
    end
  end

  # Instance methods
  attr_reader :stations, :name

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    @name = "#{start_station.name}-#{end_station.name}"
    self.class.all << self
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

  private

  def validate!
    raise 'The stations have an invalid format.' unless stations.all? { |station| station.is_a?(Station) }
    raise 'The stations are the same.' if stations[0] == stations[1]
  end
end
