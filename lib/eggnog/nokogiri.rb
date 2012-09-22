require "nokogiri"
require File.expand_path("../nokogiri/node", __FILE__)
require File.expand_path("../nokogiri/builder", __FILE__)

module Eggnog
  class XML
    class Builder
      include ::Eggnog::Nokogiri::Builder
    end
  end
end
