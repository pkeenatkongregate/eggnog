require "eggnog/version"

# Eggnog XML dependencies
require "eggnog/xml"
require "eggnog/xml/builder"

# Eggnog JSON dependencies
require "eggnog/json"
require "eggnog/json/builder"

module Eggnog
  # The default parser
  # @return [ Symbol ]
  # @api private
  def self.default_parser
    return :ox       if defined?(::Ox)
    return :nokogiri if defined?(::Nokogiri)

    [:ox, :nokogiri].each do |parser|
      begin
        require parser.to_s
        return parser
      rescue LoadError
        next
      end
    end
  end
end

require "eggnog/#{Eggnog.default_parser}"
