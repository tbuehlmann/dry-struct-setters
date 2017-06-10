require 'spec_helper'

RSpec.describe Dry::Struct::Setters::MassAssignment do
  let(:struct) do
    Class.new(Dry::Struct) do
      include Dry::Struct::Setters
      include Dry::Struct::Setters::MassAssignment

      attribute :foo, Dry::Struct::Setters::Types::String
      attribute :bar, Dry::Struct::Setters::Types::String
    end
  end

  subject { struct.new(foo: 'foo', bar: 'bar') }

  describe 'including Dry::Struct::Setters::MassAssignment' do
    it 'defines an assign_attributes methods' do
      subject.assign_attributes(foo: 'new-foo', bar: 'new-bar')

      expect(subject.foo).to eq('new-foo')
      expect(subject.bar).to eq('new-bar')
    end
  end
end
