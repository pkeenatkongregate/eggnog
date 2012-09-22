module Eggnog
  class JSON
    class Builder

      DEFAULT_OPTIONS = {}.freeze

      def initialize(json, options)
        @node, @options = json_to_node(json), merge_options(options)
      end

      def to_hash(parent_hash = {})
      end

      private

      attr_reader :node, :options

      def json_to_node(json)
      end

      def merge_options(options)
        DEFAULT_OPTIONS.merge(options)
      end
    end # Builder
  end # JSON
end # Eggnog
