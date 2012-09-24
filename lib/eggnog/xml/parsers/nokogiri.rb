require "nokogiri" unless defined?(Nokogiri)

module Eggnog
  module XML
    module Parsers
      class Nokogiri < Base

        def self.parse_error
          ::Nokogiri::XML::SyntaxError
        end

        def parse(xml)
          doc = ::Nokogiri::XML(xml)
          raise doc.errors.first if doc.errors.length > 0
          node_to_hash(doc.root)
        end

        private

        def node_name(node)
          node.node_name
        end

        def node_content(node)
          node.text.strip
        end

        def node_has_content?(node)
          node.element? &&
            node.children.size > 0 &&
            node.children.all? {|c| c.text? || c.cdata? }
        end

        def node_children(node)
          node.children
        end

        def node_has_children?(node)
          node.element? && 
            node.children.size > 0 && 
            node.children.none? {|child| child.text? }
        end

        def node_attributes(node)
          ({}).tap do |attributes|
            node.attribute_nodes.each {|a| attributes[node_name(a)] = node_content(a) }
          end
        end

      end # Nokogiri
    end # Parsers
  end # XML
end # Eggnog
