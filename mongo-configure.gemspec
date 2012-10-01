# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mongo-configure/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jon Rowe"]
  gem.email         = ["hello@jonrowe.co.uk"]
  gem.description   = %q{A simple gem for configuring mongo databases.}
  gem.summary       = %q{A simple gem for configuring mongo databases.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mongo-configure"
  gem.require_paths = ["lib"]
  gem.version       = Mongo::Configure::VERSION

  gem.add_development_dependency 'rspec'
end
