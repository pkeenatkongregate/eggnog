require "rubygems"
require "bundler/setup"
require "rspec"

require File.expand_path("../../lib/eggnog", __FILE__)

# Shared examples
Dir["./spec/shared/**/*.rb"].each {|f| require f}

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.filter_run :focus => true
  c.run_all_when_everything_filtered = true
end

def fixture_file(filename)
  File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
end
