module Eggnog
  module XML
    module Mixins
      module Ox 
        def to_hash(options = {})
          Eggnog::XML::Parsers::Ox.parse(self, options)
        end
      end
    end
  end
end

class ::Ox::Node
  include Eggnog::XML::Mixins::Ox
end
