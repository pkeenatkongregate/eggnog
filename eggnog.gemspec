# -*- encoding: utf-8 -*-
require File.expand_path('../lib/eggnog/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan Closner"]
  gem.email         = ["ryan@ryanclosner.com"]
  gem.description   = %q{Nokogiri Mixin - Converts Nodes to a Hash}
  gem.summary       = %q{Nokogiri Mixin - Converts Nodes to a Hash}
  gem.homepage      = "http://github.com/rclosner/eggnog"

  runtime_dependencies = {
    "nokogiri"   => "~> 1.5.5"
  }

  runtime_dependencies.each {|lib, version| gem.add_runtime_dependency(lib, version) }

  development_dependencies = {
    "rake"     => "~> 0.9.2",
    "rspec"    => "~> 2.7.0"
  }

  development_dependencies.each {|lib, version| gem.add_development_dependency(lib, version) }


  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "eggnog"
  gem.require_paths = ["lib"]
  gem.version       = Eggnog::VERSION
end
