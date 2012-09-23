require "spec_helper"
require "eggnog/nokogiri"

describe Eggnog::XML::Builder do

  context "using Ox" do
    before do
      Eggnog::XML::Builder.send(:include, Eggnog::Ox::Builder)
    end

    it_behaves_like "an XML Builder"
  end

  context "using Nokogiri" do
    before do
      Eggnog::XML::Builder.send(:include, Eggnog::Nokogiri::Builder)
    end

    it_behaves_like "an XML Builder"
  end

end
