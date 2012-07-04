class Nokogiri::XML::Node
  def to_hash(options = {})
    Eggnog::NodeDecorator.to_hash(self, options)
  end
end
