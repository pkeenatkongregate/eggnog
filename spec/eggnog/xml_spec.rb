require "spec_helper"

describe Eggnog::XML do
  describe ".parse" do
    let(:xml)     { '<?xml version="1.0"?><foo/>' }
    let(:options) { {} }

   it "returns a Hash" do
      described_class.parse(xml, options).should be_a(Hash)
    end
  end
end
