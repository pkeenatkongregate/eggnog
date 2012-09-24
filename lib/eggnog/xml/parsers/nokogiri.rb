require "nokogiri" unless defined?(Nokogiri)

module Eggnog
  module XML
    module Parsers
      class Nokogiri < Base

        # @return [ Nokogiri::XML::SyntaxError ]
        # @api private
        def self.parse_error
          ::Nokogiri::XML::SyntaxError
        end

        # @return [ Hash ]
        # @api private
        def parse(xml)
          case xml
          when ::Nokogiri::XML::Node
            doc = xml
          when String
            doc = ::Nokogiri::XML(xml)
          end

          raise doc.errors.first if doc.errors.length > 0

          node_to_hash(doc.root)
        end

        private

        # @return [ String ]
        # @api private
        def node_name(node)
          node.node_name
        end

        # @return [ String ]
        # @api private
        def node_content(node)
          node.text.strip
        end

        # @return [ Boolean ]
        # @api private
        def node_has_content?(node)
          node.element? &&
            node.children.length > 0 &&
            node.children.all? {|c| c.text? || c.cdata? }
        end

        # @return [ Array ]
        # @api private
        def node_children(node)
          node.children.select {|c| c.element? }
        end

        # @return [ Boolean ]
        # @api private
        def node_has_children?(node)
          node.element? && 
            node_children(node).length > 0 && 
            node_children(node).all? {|c| c.element? }
        end

        # @return [ Hash ]
        # @api private
        def node_attributes(node)
          ({}).tap do |attributes|
            node.attribute_nodes.each {|a| attributes[node_name(a)] = node_content(a) }
          end
        end

      end # Nokogiri
    end # Parsers
  end # XML
end # Eggnog
