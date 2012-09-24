module Eggnog
  module XML
    module Parsers
      class Base

        # @return [ Eggnog::XML::Parsers::Base ]
        # @api private
        def initialize(options = {})
          @options = merge_options(options)
        end

        # @return [ Hash ]
        # @api public
        def self.parse(xml, options = {})
          new(options).parse(xml)
        end

        # @return [ Object ]
        # @api public
        def self.parse_error(*args)
          raise NotImplementedError, "inheritor should define #{__method__}"
        end

        # @return [ Hash ]
        # @api public 
        def parse(*args)
          raise NotImplementedError, "inheritor should define #{__method__}"
        end

        private

        # @return [ Hash ]
        # @api private
        attr_reader :options

        # @return [ Hash ]
        # @api private
        def node_to_hash(node, hash = {})
          node_hash = node_elements_and_attributes_to_hash(node)
          name      = node_name(node)
          
          # Undasherize keys
          if options[:undasherize_keys]
            name = "#{name}".tr("-", "_") 
          end

          # Symbolize keys
          if options[:symbolize_keys]
            name = :"#{name}"
          end

          # Insert node hash into parent hash correctly
          case hash[name]
            when NilClass then hash[name] = node_hash
            when Hash     then hash[name] = [ hash[name], node_hash ]
            when Array    then hash[name] << node_hash
          end

          hash
        end

        # @return [ Object ]
        # @api private
        def node_elements_and_attributes_to_hash(node)
          node_elements_hash = node_elements_to_hash(node)

          # Return node contents hash unless attributes are to be preserved
          unless options[:preserve_attributes]
            return node_elements_hash
          end

          # If node attributes are to be preserved
          node_attributes_hash = node_attributes(node)

          # When no attributes are present
          if node_attributes_hash.empty?
            return node_elements_hash
          end

          # When children are present, merge with attributes. Else, namespace with CONTENT_ROOT
          if node_elements_hash.is_a?(Hash)
            node_attributes_hash.merge!(node_elements_hash)
          else
            unless node_elements_hash.strip.empty?
              node_attributes_hash[Eggnog::XML::CONTENT_ROOT] = node_elements_hash
            end
          end
          
          node_attributes_hash
        end

        # @return [ Object ]
        # @api private
        def node_elements_to_hash(node)
          if node_has_children?(node)
            node_children_to_hash(node)
          elsif node_has_content?(node)
            node_content_to_hash(node)
          else
            {}
          end
        end

        # @return [ Object ]
        # @api private
        def node_children_to_hash(node)
          ({}).tap do |node_children_hash|
            each_child(node) do |child|
              node_to_hash(child, node_children_hash)
            end
          end
        end

        # @return [ Object ]
        # @api private
        def node_content_to_hash(node)
          node_content(node)
        end

        # Child node iterator convenience method
        # @return [ Array ]
        # @api private
        def each_child(node, &block)
          node_children(node).each(&block)
        end

        # Methods to be defined in inheritor
        
        # @return [ Exception ]
        # @api private
        def node_children(*args)
          raise NotImplementedError, "inheritor should define #{__method__}"
        end
   
        # @return [ Exception ]
        # @api private
        def node_has_children?(*args)
          raise NotImplementedError, "inheritor should define #{__method__}"
        end

        # @return [ Exception ]
        # @api private
        def node_content(*args)
          raise NotImplementedError, "inheritor should define #{__method__}"
        end

        # @return [ Exception ]
        # @api private
        def node_has_content?(*args)
          raise NotImplementedError, "inheritor should define #{__method__}"
        end
      
        # @return [ Exception ]
        # @api private
        def node_name(*args)
          raise NotImplementedError, "inheritor should define #{__method__}"
        end
        
        # @return [ Exception ]
        # @api private
        def node_attributes(*args)
          raise NotImplementedError, "inheritor should define #{__method__}"
        end

        # @return [ Hash ]
        # @api private
        def merge_options(options)
          Eggnog::XML::DEFAULT_OPTIONS.merge(options)
        end

      end # Base
    end # Parsers
  end # XML
end # Eggnog
