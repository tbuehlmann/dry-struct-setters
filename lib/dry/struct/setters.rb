# frozen_string_literal: true

require 'dry/struct'

require 'dry/struct/setters/mass_assignment'
require 'dry/struct/setters/version'

module Dry
  class Struct
    module Setters
      def self.included(struct)
        struct.extend(ClassMethods)

        struct.schema.each do |key|
          Dry::Struct::Setters.define_setter_for(struct: struct, attribute: key.name, type: key.type)
        end

        def []=(key, value)
          if self.class.schema.key?(key)
            public_send("#{key}=", value)
          else
            raise Dry::Struct::MissingAttributeError, key
          end
        end
      end

      module ClassMethods
        def attributes(new_schema)
          super.tap do
            new_schema.each do |attribute, type|
              Dry::Struct::Setters.define_setter_for(struct: self, attribute: attribute, type: type)
            end
          end
        end
      end

      def self.define_setter_for(struct:, attribute:, type:)
        attribute = remove_trailing_question_mark(attribute)
        setter = "#{attribute}=".to_sym

        struct.class_eval do
          unless instance_methods.include?(setter)
            define_method(setter) do |value|
              @attributes[attribute] = type.call(value)
            end

            setter
          end
        end
      end

      def self.remove_trailing_question_mark(attribute)
        #  See https://github.com/tbuehlmann/dry-struct-setters/issues/2
        attribute.to_s.chomp('?').to_sym
      end
    end
  end
end
