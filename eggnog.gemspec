# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eggnog/version'

Gem::Specification.new do |gem|
  gem.name          = "eggnog"
  gem.version       = Eggnog::VERSION
  gem.authors       = ["Ryan Closner"]
  gem.email         = ["ryan@ryanclosner.com"]
  gem.summary       = %q{JSON and XML parsing made easy.}
  gem.homepage      = "http://github.com/rclosner/eggnog"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  development_dependencies = {
    "rake"  => "~> 0.9.2.2",
    "rspec" => "~> 2.11.0"
  }

  development_dependencies.each {|lib, version| gem.add_development_dependency(lib, version) }

  runtime_dependencies = {
    "ox" => "~> 1.6.0",
    "nokogiri" => "~> 1.5.5",
    "oj" => "~> 1.3.4"
  }

  runtime_dependencies.each {|lib, version| gem.add_runtime_dependency(lib, version) }

end
