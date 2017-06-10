require 'spec_helper'

RSpec.describe Dry::Struct do
  let(:struct) do
    Class.new(Dry::Struct) do
      attribute :foo, Dry::Struct::Setters::Types::String
    end
  end

  subject { struct.new(foo: 'foo') }

  it 'doesn’t define setters' do
    expect(subject).to_not respond_to(:foo=)
  end
end
