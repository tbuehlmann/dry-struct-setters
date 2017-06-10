# frozen_string_literal: true

require 'dry/struct/setters'

module Dry
  class Struct
    class WithSetters < Dry::Struct
      include Dry::Struct::Setters
      include Dry::Struct::Setters::MassAssignment
    end
  end
end
