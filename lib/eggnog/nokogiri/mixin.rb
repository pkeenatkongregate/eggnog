require File.expand_path("../nokogiri", __FILE__)

module Eggnog
  module Nokogiri
    module Mixin
      def to_hash(options = {})
        Eggnog::XML::Builder.to_hash(node, options)
      end
    end
  end
end

class Nokogiri::XML::Node
  include Eggnog::Nokogiri::Mixin
end
