module Eggnog
  class XML

    def self.parse(xml, options = {})
      new(xml, options).to_hash
    end

    def initialize(xml, options = {})
      @xml, @options = xml, options
    end

    def to_hash
      Eggnog::XML::Builder.to_hash(xml, options)
    end

    private

    attr_reader :xml, :options
  end # XML
end # Eggnog
