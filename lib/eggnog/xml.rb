module Eggnog
  module XML

    class ParseError < StandardError; end

    PARSERS         = [ :ox, :nokogiri ].freeze
    CONTENT_ROOT    = "__content__".freeze
    DEFAULT_OPTIONS = {
      :preserve_attributes => false,
      :undasherize_keys    => false,
      :symbolize_keys      => false
    }.freeze

    def self.parser
      return @@parser if defined?(@@parser)
      self.parser = self.default_parser
      @@parser
    end

    def self.parser=(new_parser)
      if PARSERS.include?(new_parser)
        @@parser = Eggnog::XML::Parsers.const_get("#{new_parser.to_s.split('_').map{|s| s.capitalize}.join('')}")
      else
        raise ArgumentError, "did not recognize your parser specification."
      end
    end

    def self.parse(xml, options = {})
      xml ||= ''

      unless xml.is_a?(String)
        raise ArgumentError, "+xml+ must be instance of String"
      end

      xml = xml.gsub(/([\302|\240|\s|\n|\t])|(\&nbsp;?){1,}/, ' ').strip

      unless xml.length > 0
        return {}
      end

      begin
        hash = parser.parse(xml, options)
      rescue parser.parse_error => error
        raise ParseError, error.to_s, error.backtrace
      end

      hash
    end

    private

    # The default parser
    # @return [ Symbol ]
    # @api private
    def self.default_parser
      return :ox       if defined?(::Ox)
      return :nokogiri if defined?(::Nokogiri)

      PARSERS.each do |parser|
        begin
          require parser.to_s
          return parser
        rescue LoadError
          next
        end
      end
    end


  end # XML
end # Eggnog
