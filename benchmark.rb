require "benchmark"

# Eggnog

require File.expand_path("../lib/eggnog/xml", __FILE__)
require File.expand_path("../lib/eggnog/xml/parsers/base", __FILE__)
require File.expand_path("../lib/eggnog/xml/parsers/ox", __FILE__)
require File.expand_path("../lib/eggnog/xml/parsers/nokogiri", __FILE__)

# MultiXml

require "multi_xml"

# Crack

require "crack"

@xml =<<DOC
<topics type="array">
  <topic>
    <title>The First Topic</title>
    <author-name>David</author-name>
    <id type="integer">1</id>
    <approved type="boolean">false</approved>
    <replies-count type="integer">0</replies-count>
    <replies-close-in type="integer">2592000000</replies-close-in>
    <written-on type="date">2003-07-16</written-on>
    <viewed-at type="datetime">2003-07-16T09:28:00+0000</viewed-at>
    <content>Have a nice day</content>
    <author-email-address>david@loudthinking.com</author-email-address>
    <parent-id nil="true"></parent-id>
  </topic>
  <topic>
    <title>The Second Topic</title>
    <author-name>Jason</author-name>
    <id type="integer">1</id>
    <approved type="boolean">false</approved>
    <replies-count type="integer">0</replies-count>
    <replies-close-in type="integer">2592000000</replies-close-in>
    <written-on type="date">2003-07-16</written-on>
    <viewed-at type="datetime">2003-07-16T09:28:00+0000</viewed-at>
    <content>Have a nice day</content>
    <author-email-address>david@loudthinking.com</author-email-address>
    <parent-id></parent-id>
  </topic>
</topics>
DOC

Eggnog::XML.parser = :ox

def xml
  String.new(@xml)
end

def nog(options = {})
  Eggnog::XML.parse(xml, options)
end

def multi_xml(options = {})
  MultiXml.parse(xml, options)
end

def crack(options = {})
  Crack::XML.parse(xml)
end


def benchmark
  n = 100000
  Benchmark.bm do |x|

    puts "Benchmarking Eggnog:"
    x.report { n.times { nog } }

    puts "Benchmarking MultiXml:"
    x.report { n.times { multi_xml }}

    puts "Benchmarking Crack:"
    x.report { n.times { crack }}

  end
end
