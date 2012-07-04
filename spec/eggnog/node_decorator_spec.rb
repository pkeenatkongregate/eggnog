require "spec_helper"

describe Eggnog::NodeDecorator do
  subject { described_class.new(node, options) }

  let(:node)    { Nokogiri::XML(xml).root }
  let(:xml)     { "<foo boo='baz'>bar</foo>"}
  let(:options) { {} }

  describe "#to_hash" do
    it "returns a Hash" do
      subject.to_hash.should be_a(Hash)
    end

    it "converts xml node into a hash" do
      subject.to_hash.should eql({"foo" => "bar"})
    end

    context "preserve_attributes => true" do
      let(:options) { { :preserve_attributes => true } }

      it "preserves xml attributes" do
        subject.to_hash.should eql({"foo" => {"__content__" => "bar", "boo" => "baz" } })
      end
    end
  end

  describe ".to_hash" do
    it "returns a hash" do
      described_class.to_hash(node, options).should be_a(Hash)
    end
  end
end
