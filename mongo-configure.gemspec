# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mongo/configure/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jon Rowe"]
  gem.email         = ["hello@jonrowe.co.uk"]
  gem.description   = %q{A simple gem for configuring mongo databases.}
  gem.summary       = %q{A simple gem for configuring mongo databases.}
  gem.homepage      = "https://github.com/JonRowe/mongo-configure"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mongo-configure"
  gem.require_paths = ["lib"]
  gem.version       = Mongo::Configure::VERSION
  gem.license       = 'MIT'

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_dependency 'mongo', '~> 2.4'

  gem.add_development_dependency 'rspec'

  if RUBY_VERSION.to_f < 2
    gem.add_development_dependency "rake", '~> 10.0'
  elsif
    gem.add_development_dependency "rake", '~> 12.3.3'
  end
end
