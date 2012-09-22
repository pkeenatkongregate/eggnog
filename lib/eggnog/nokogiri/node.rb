# Wrapper for Nokogiri::XML::Node

module Eggnog
  module Nokogiri
    class Node

      # Initializes a new Eggnog::Nokogiri::Node object
      # @return [ Eggnog::Nokogiri::Node ]
      # @api private
      def initialize(object)
        @object = object
      end
 
      # Convenience method to determine whether node is root node
      # @return [ Boolean ]
      # @api public
      def root?
        object.is_a?(::Nokogiri::XML::Document)
      end

      def attributes
        ({}).tap do |output|
          object.attribute_nodes.each {|a| output[a.name] = a.value }
        end 
      end

      def content
        object_content = object.content

        case object_content
        when String
          if object_content.size > 0
            object_content
          else
            {}
          end
        else
          object_content
        end
      end

      # Convenience method to access object child nodes
      # @return [ Array ]
      # @api public
      def children
        @children ||= element_children.map {|child| self.class.new(child) }
      end

      # Convenience method to determine whether node has child nodes
      # @return [ Boolean ]
      # @api public
      def has_children?
        element_children.size > 0
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

    end
  end
end
