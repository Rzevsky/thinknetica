require_relative '../modules/manufacturer'
require_relative '../modules/instance_counter'

class Wagon
  include Manufacturer

  attr_reader :type

  def initialize(type)
    @type = type
  end
end
