module Eggnog
  module Nokogiri
    module Builder

      # Exposes the XML parsing library being utilized by Eggnog::XML::Builder
      # @return [ Symbol ]
      # @api public
      def self.xml_parsing_adapter
        :nokogiri
      end

      private

      # Returns wrapped node object from raw XML
      # @return [ Object ]
      # @api private
      def xml_to_node(xml)
        case xml
        when String
          Eggnog::Nokogiri::Node.new(::Nokogiri::XML(xml))
        when ::Nokogiri::XML::Node
          Eggnog::Nokogiri::Node.new(xml)
        when Eggnog::Nokogiri::Node
          xml
        end
      end

    end # Builder
  end # Nokogiri
end # Eggnog
