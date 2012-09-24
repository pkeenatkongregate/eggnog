require "spec_helper"

describe Eggnog::XML::Parsers::Ox do
  let(:parser) { :ox }
  it_behaves_like "an XML parser"  
end
