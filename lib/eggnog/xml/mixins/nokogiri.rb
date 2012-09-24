module Eggnog
  module XML
    module Mixins
      module Nokogiri
        def to_hash(options = {})
          Eggnog::XML::Parsers::Nokogiri.parse(self, options)
        end
      end
    end
  end
end

class Nokogiri::XML::Node
  include Eggnog::XML::Mixins::Nokogiri
end
