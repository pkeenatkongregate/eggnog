module Eggnog
  module Ox
    module Mixin
      def to_hash(options = {})
        Eggnog::XML::Builder.to_hash(node, options)
      end
    end
  end
end

class Ox::Node
  include Eggnog::Ox::Mixin
end
