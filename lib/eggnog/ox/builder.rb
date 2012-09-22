module Eggnog
  module Ox
    module Builder

      # Exposes the XML parsing library being utilized by Eggnog::XML::Builder
      # @return [ Symbol ]
      # @api public
      def self.xml_parsing_adapter
        :ox
      end

      private

      # Returns wrapped node object from raw XML
      # @return [ Object ]
      # @api private
      def xml_to_node(xml)
        case xml
        when String
          hacky_ox_symbolize_keys_bullshit
          Eggnog::Ox::Node.new(::Ox.parse(xml))
        when ::Ox::Node
          Eggnog::Ox::Node.new(xml)
        when Eggnog::Ox::Node
          xml
        end
      end

      # TODO: REMOVE THIS ASAP.
      # This method is set in place to maintain the consistency of utilizing strings as keys.
      # Ox should provide the ability to use a runtime options Hash as opposed to a default
      # Hash
      def hacky_ox_symbolize_keys_bullshit
        ::Ox.default_options = ::Ox.default_options.merge(:symbolize_keys => false)
      end

    end # Builder
  end # Ox
end # Eggnog
