# frozen_string_literal: true

module Dry
  class Struct
    module Setters
      module MassAssignment
        def assign_attributes(attributes = {})
          attributes.each do |attribute, value|
            public_send("#{attribute}=", value)
          end
        end
      end
    end
  end
end
