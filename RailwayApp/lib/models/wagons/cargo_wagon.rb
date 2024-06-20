require_relative '../wagon'

class CargoWagon < Wagon
  def initialize
    super(:crg)
  end
end
