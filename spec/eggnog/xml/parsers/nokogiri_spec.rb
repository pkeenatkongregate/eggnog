require "spec_helper"

describe Eggnog::XML::Parsers::Nokogiri do
  let(:parser) { :nokogiri }
  it_behaves_like "an XML parser"  
end
