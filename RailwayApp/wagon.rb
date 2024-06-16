# frozen_string_literal: true

class Wagon
  attr_reader :type

  def initialize(type)
    @type = type
  end
end

class PassengerWagon < Wagon
  def initialize
    super(:psg)
  end
end

class CargoWagon < Wagon
  def initialize
    super(:crg)
  end
end
