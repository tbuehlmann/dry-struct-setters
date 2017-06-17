require_relative 'lib/dry/struct/setters/version'

Gem::Specification.new do |spec|
  spec.name          = 'dry-struct-setters'
  spec.version       = Dry::Struct::Setters::VERSION
  spec.authors       = ['Tobias Bühlmann']
  spec.email         = ['tobias@xn--bhlmann-n2a.de']

  spec.summary       = 'Setter methods for Dry::Struct subclasses'
  spec.description   = 'This gem adds the ability to add setter methods to otherwise setter-method-less Dry::Struct subclasses.'
  spec.homepage      = 'https://github.com/tbuehlmann/dry-struct-setters'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1'

  spec.add_runtime_dependency 'dry-struct', '>= 0.3.0'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
end
