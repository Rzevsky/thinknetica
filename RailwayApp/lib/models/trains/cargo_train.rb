require_relative '../train'

class CargoTrain < Train
  def initialize(number, wagons = 0)
    super(:crg, number, wagons)
  end

  def add_wagon
    return unless speed.zero?

    @wagons << CargoWagon.new
  end
end
