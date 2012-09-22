module Eggnog
  class XML
    class Builder

      CONTENT_KEY = "__content__".freeze
      DEFAULT_OPTIONS = {
        :preserve_attributes => false,
        :include_root        => false 
      }.freeze

      def initialize(xml, options)
        @node, @options = xml_to_node(xml), merge_options(options)
      end

      # Transforms XML into Hash
      # @return [ Hash ]
      # @api public
      def self.to_hash(xml, options)
        new(xml, options).to_hash
      end

      # Transforms node into Hash
      # @return [ Hash ]
      # @api public
      def to_hash(parent_hash = {})
        node_hash = hashify_node

        if node.root?
          if options[:include_root]
            node_hash
          else
            hashify_node_contents
          end
        else
          insert_into_parent_hash(node_hash, parent_hash)
        end
      end

      private

      attr_reader :node, :options

      # Inserts node Hash into parent Hash
      # @return [ Hash ]
      # @api private
      def insert_into_parent_hash(node_hash, parent_hash)
        parent_hash.tap do |h|
          case h[node.name]
          when NilClass then h[node.name] = node_hash 
          when Hash     then h[node.name] = [ h[node.name], node_hash ]
          when Array    then h[node.name] << node_hash 
          end
        end
      end

      # Converts node into Hash 
      # @return [ Object ]
      # @api private
      def hashify_node
        node_contents = hashify_node_contents

        if options[:preserve_attributes]
          unless node.root? && !options[:include_root]
            node_attributes = hashify_node_attributes 

            if node_attributes.empty?
              output = node_contents
            else
              output = node_attributes

              if node_contents 
                output[CONTENT_KEY] = node_contents
              end
            end

            output
          else
            node_contents
          end
        else
          node_contents
        end || {}
      end

      # Returns node attributes
      # @return [ Object ]
      # @api private
      def hashify_node_attributes
        node.attributes
      end

      # Returns node contents
      # @return [ Object ]
      # @api private
      def hashify_node_contents
        if node.has_children?
          ({}).tap do |output|
            node.children.each do |child|
              unless child.comment?
                child_builder = self.class.new(child, options)
                child_builder.to_hash(output)
              end
            end
          end
        else
          node.content
        end
      end

      # Returns wrapped node object from raw XML
      # @return [ Object ]
      # @api private
      # def xml_to_node(xml)
      # end

      # Merges options with default options
      # @return [ Hash ]
      # @api private
      def merge_options(options)
        DEFAULT_OPTIONS.merge(options)
      end

    end
  end
end
