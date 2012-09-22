module Eggnog
  class JSON

    def self.parse(json, options = {})
      new(json, options).to_hash
    end

    def initialize(json, options = {})
      @json, @options = json, options
    end

    def to_hash
      Eggnog::JSON::Builder.to_hash(xml, options)
    end

    private

    attr_reader :json, :options

  end # JSON
end # Eggnog
