# Wrapper for Ox::Node

module Eggnog
  module Ox
    class Node

      # Initializes a new Eggnog::Ox::Node object
      # @return [ Eggnog::Ox::Node ]
      # @api private
      def initialize(object)
        @object = object
      end

      # Convenience method to determine whether node is root node
      # @return [ Boolean ]
      # @api public
      def root?
        object.is_a?(::Ox::Document)
      end

      # Convenience method to determine whether node is a comment node
      # @return [ Boolean ]
      # @api public
      def comment?
        object.is_a?(::Ox::Comment)
      end

      # Convenience method to access node content
      # @return [ Object ]
      # @api public
      def content 
        (has_children? ? children : object.nodes.first) || {}
      end

      # Convenience method to access object child nodes
      # @return [ Array ]
      # @api public
      def children
        @children ||= object.nodes.map {|child| self.class.new(child) }
      end

      # Convenience method to determine whether node has child nodes
      # @return [ Boolean ]
      # @api public
      def has_children?
        object.nodes.size > 0 && object.nodes.all? {|child| child.is_a?(::Ox::Node) }
      end

      # Override default respond_to? functionality
      # @return [ Boolean ]
      # @api public
      def respond_to?(m, include_private = false)
        object.respond_to?(m, include_private) || super
      end

      private

      attr_reader :object

      # Delegate all missing methods to object
      def method_missing(m, *args, &block)
        object.send(m, *args, &block)
      end

    end # Node
  end # Ox
end # Eggnog
