# Класс Route (Маршрут):
# Имеет начальную и конечную станцию, а также список промежуточных станций.
# Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться
# между ними.
# Может добавлять промежуточную станцию в список.
# Может удалять промежуточную станцию из списка.
# Может выводить список всех станций по-порядку от начальной до конечной.

require_relative 'Station'

class Route
  attr_accessor :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station) if station != stations.first && station != stations.last
  end

  def display_stations
    stations.each { |station| puts station.name }
  end
end
