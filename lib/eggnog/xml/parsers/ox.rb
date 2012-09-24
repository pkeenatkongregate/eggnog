require "ox" unless defined?(Ox)

module Eggnog
  module XML
    module Parsers
      class Ox < Base

        def self.parse_error
          Exception
        end

        def parse(xml)
          doc = ::Ox.load(xml, :symbolize_keys => false)

          if node_is_document?(doc)
            doc = doc.root
          end

          node_to_hash(doc)
        end

        private

        def node_name(node)
          node.name
        end

        def node_content(node)
          child = node_children(node).first

          if node_is_text?(child)
            child
          elsif node_is_cdata?(child)
            child.value
          end
        end

        def node_has_content?(node)
          node_is_node?(node) &&
            node_children(node).length > 0 &&
            node_children(node).all? {|c| node_is_text?(c) || node_is_cdata?(c) }
        end

        def node_children(node)
          node.nodes
        end

        def node_has_children?(node)
          node_is_element?(node) &&
            node_children(node).length > 0 &&
            node_children(node).all? {|c| node_is_element?(c) }
        end

        def node_attributes(node)
          node.attributes
        end

        # Type checking convenience methods
        
        def node_is_node?(node)
          node.is_a?(::Ox::Node)
        end

        def node_is_element?(node)
          node.is_a?(::Ox::Element)
        end

        def node_is_cdata?(node)
          node.is_a?(::Ox::CData)
        end

        def node_is_comment?(node)
          node.is_a?(::Ox::Comment)
        end

        def node_is_doc_type?(node)
          node.is_a?(::Ox::DocType)
        end

        def node_is_document?(node)
          node.is_a?(::Ox::Document)
        end

        def node_is_text?(node)
          node.is_a?(::String)
        end

      end # Ox
    end # Parsers
  end # XML
end # Eggnog
