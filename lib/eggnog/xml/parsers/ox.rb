require "ox" unless defined?(Ox)

module Eggnog
  module XML
    module Parsers
      class Ox < Base

        # @return [ Nokogiri::XML::SyntaxError ]
        # @api private
        def self.parse_error
          Exception
        end

        # @return [ Hash ]
        # @api private
        def parse(xml)
          case xml
          when ::Ox::Node
            doc = xml
          when String
            doc = ::Ox.load(xml, :symbolize_keys => false)
          end

          if node_is_document?(doc)
            doc = doc.root
          end

          node_to_hash(doc)
        end

        private

        # @return [ String ]
        # @api private
        def node_name(node)
          node.name
        end

        # @return [ String ]
        # @api private
        def node_content(node)
          child = node_children(node).first

          if node_is_text?(child)
            child
          elsif node_is_cdata?(child)
            child.value
          end
        end
        
        # @return [ Boolean ]
        # @api private
        def node_has_content?(node)
          node_is_node?(node) &&
            node_children(node).length > 0 &&
            node_children(node).all? {|c| node_is_text?(c) || node_is_cdata?(c) }
        end

        # @return [ Array ]
        # @api private
        def node_children(node)
          node.nodes
        end

        # @return [ Boolean ]
        # @api private
        def node_has_children?(node)
          node_is_element?(node) &&
            node_children(node).length > 0 &&
            node_children(node).all? {|c| node_is_element?(c) }
        end

        # @return [ Hash ]
        # @api private
        def node_attributes(node)
          node.attributes
        end

        # Type checking convenience methods
        
        # @return [ Boolean ]
        # @api private
        def node_is_node?(node)
          node.is_a?(::Ox::Node)
        end

        # @return [ Boolean ]
        # @api private
        def node_is_element?(node)
          node.is_a?(::Ox::Element)
        end

        # @return [ Boolean ]
        # @api private
        def node_is_cdata?(node)
          node.is_a?(::Ox::CData)
        end

        # @return [ Boolean ]
        # @api private
        def node_is_comment?(node)
          node.is_a?(::Ox::Comment)
        end

        # @return [ Boolean ]
        # @api private
        def node_is_doc_type?(node)
          node.is_a?(::Ox::DocType)
        end

        # @return [ Boolean ]
        # @api private
        def node_is_document?(node)
          node.is_a?(::Ox::Document)
        end

        # @return [ Boolean ]
        # @api private
        def node_is_text?(node)
          node.is_a?(::String)
        end

      end # Ox
    end # Parsers
  end # XML
end # Eggnog
