require_relative '../train'

class PassengerTrain < Train
  def initialize(number, wagons = 0)
    super(:psg, number, wagons)
    # @type = :psg
  end

  def add_wagon
    return unless speed.zero?

    @wagons << PassengerWagon.new
  end
end
