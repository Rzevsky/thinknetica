require_relative '../modules/manufacturer'
require_relative '../modules/instance_counter'
require_relative '../modules/validation'

class Wagon
  include Manufacturer
  include Validation

  attr_reader :type

  VALID_TYPES = %i[psg crg].freeze

  def initialize(type)
    @type = type
    validate!
  end

  private

  def validate!
    raise 'The type has an invalid format.' unless VALID_TYPES.include?(type)
  end
end
