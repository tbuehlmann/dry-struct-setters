# Dry::Struct::Setters

[![Gem Version](https://badge.fury.io/rb/dry-struct-setters.svg)](http://badge.fury.io/rb/dry-struct-setters) [![Build Status](https://travis-ci.org/tbuehlmann/dry-struct-setters.svg?branch=master)](https://travis-ci.org/tbuehlmann/dry-struct-setters)

Dry::Struct::Setters is an extension to the [Dry::Struct](https://github.com/dry-rb/dry-struct) library. Subclasses of Dry::Struct only define getter methods for its attributes by design (or preference). This library extends subclasses so they also provide setter methods.

## Usage

By including the Dry::Struct::Setters module into your Dry::Struct subclass every defined attribute will get a corresponding setter method:

```ruby
module Types
  include Dry::Types.module
end

class Project < Dry::Struct
  include Dry::Struct::Setters

  attribute :name, Types::String
end

project = Project.new(name: 'some-project')
project.name = 'some-project-new'

project.name # => 'some-project-new'
```

### Mass Assignment

Including the Dry::Struct::Setters module into you Dry::Struct subclass will only define setter methods, mass assigning attributes won't work with this. If you want to be able to mass assign attributes, just include the Dry::Struct::Setters::MassAssignment module, which will provide an assign_attributes method:

```ruby
module Types
  include Dry::Types.module
end

class Project < Dry::Struct
  include Dry::Struct::Setters
  include Dry::Struct::Setters::MassAssignment

  attribute :name, Types::String
  attribute :description, Types::String
end

project = Project.new(name: 'some-project', description: 'some-description')

project.assign_attributes(name: 'some-project-new', description: 'some-description-new')

project.name # => 'some-project-new'
project.description # => 'some-description-new'
```

### Convenience Class

Instead of including modules you can also just use the Dry::Struct::WithSetters class which inherits from Dry::Struct and includes both modules. Note that you'll need to explicitly require it:

```ruby
require 'dry/struct/with_setters'

module Types
  include Dry::Types.module
end

class Project < Dry::Struct::WithSetters
  attribute :name, Types::String
end
```

Hint: You can also require directly via your Gemfile:

```ruby
gem 'dry-struct-setters', require: 'dry/struct/with_setters'
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dry-struct-setters'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dry-struct-setters

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tbuehlmann/dry-struct-setters.
