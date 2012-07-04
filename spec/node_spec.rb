require "spec_helper"

describe Nokogiri::XML::Node do
  subject { Nokogiri::XML(xml) }

  let(:xml) {"<root><foo>bar</foo></root>"}

  describe "#to_hash" do
    let(:options) { {} }

    it "delegates to NodeDecorator" do
      Eggnog::NodeDecorator.should_receive(:to_hash).with(subject, options)
      subject.to_hash(options)
    end
  end
end
