require "nokogiri"
require "eggnog/version"
require "eggnog/node"

class Nokogiri::XML::Node
  def to_hash(options = {})
    Eggnog::Node.to_hash(self, options)
  end
end
