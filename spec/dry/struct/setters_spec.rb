require 'spec_helper'

RSpec.describe Dry::Struct::Setters do
  let(:struct) do
    Class.new(Dry::Struct) do
      attribute :before, Dry::Struct::Setters::Types::String
      include Dry::Struct::Setters
      attribute :after, Dry::Struct::Setters::Types::String
      attribute? :omittable, Dry::Struct::Setters::Types::String.optional
    end
  end

  subject { struct.new(before: 'before', after: 'after') }

  describe 'including Dry::Struct::Setters' do
    it 'defines setters for existing attributes' do
      expect { subject.before = 'new-before' }.to change(subject, :before).from('before').to('new-before')
    end

    it 'dynamically defines setters for attributes defined after the inclusion' do
      expect { subject.after = 'new-after' }.to change(subject, :after).from('after').to('new-after')
    end

    it 'defines setters for omittable attributes' do
      expect { subject.omittable = 'newly-included' }.to change(subject, :omittable).from(nil).to('newly-included')
    end

    it 'defines []= setters' do
      expect { subject[:before] = 'new-before' }.to change(subject, :before).from('before').to('new-before')
      expect { subject[:invalid] = 'invalid' }.to raise_error(Dry::Struct::MissingAttributeError, 'Missing attribute: :invalid')
    end
  end
end
