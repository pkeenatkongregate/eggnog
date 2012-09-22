require "spec_helper"

shared_examples_for "an XML Builder" do

  let(:xml)     { "" }
  let(:options) { {} }

  let(:builder) { described_class.new(xml, options) }

  describe "#to_hash" do
    subject { builder.to_hash }

    context "using standard XML" do
      let(:xml)           { fixture_file("standard.xml") }
      let(:expected_hash) { { "foo" => "bar" } }

      it { should eql(expected_hash) }

      context "when preserve attributes is true" do
        let(:options) { { :preserve_attributes => true } }
        let(:expected_hash) do
          { 
            "foo" => "bar"
          }
        end

        it { should eql(expected_hash) }
      end
    end

    context "using comment XML" do
      let(:xml)           { fixture_file("comment.xml") }
      let(:expected_hash) { { } }

      it { should eql(expected_hash) }

      context "when preserve attributes is true" do
        let(:options) { { :preserve_attributes => true } }
        let(:expected_hash) do
          {}
        end

        it { should eql(expected_hash) }
      end

    end

    context "using empty XML" do
      let(:xml)           { fixture_file("empty.xml") }
      let(:expected_hash) { { } }

      it { should eql(expected_hash) }

      context "when preserve attributes is true" do
        let(:options) { { :preserve_attributes => true } }
        let(:expected_hash) do
          {}
        end

        it { should eql(expected_hash) }
      end

    end

    context "using loner XML" do
      let(:xml)           { fixture_file("loner.xml") }
      let(:expected_hash) { { "foo" => {} } }

      it { should eql(expected_hash) }

      context "when preserve attributes is true" do
        let(:options) { { :preserve_attributes => true } }
        let(:expected_hash) do
          { 
            "foo" => {}
          }
        end

        it { should eql(expected_hash) }
      end

    end

    context "using mixed XML" do
      let(:xml)           { fixture_file("mixed.xml") }
      let(:expected_hash) { { "top" => { "second" => "Second" } } }

      it { should eql(expected_hash) }

      context "when preserve attributes is true" do
        let(:options) { { :preserve_attributes => true } }
        let(:expected_hash) do
          { 
            "top" => {
              "name"        => "Bob", 
              "__content__" => {
                "second" => "Second"
              }
            }
          }
        end

        it { should eql(expected_hash) }
      end

    end

    context "using nested XML" do
      let(:xml) { fixture_file("nested.xml") }
      let(:expected_hash) do
        {
          "Park.Animal" => {
            "type"    => "mutant", 
            "friends" => {
              "i"           => "5", 
              "Park.Animal" => {
                "type" => "dog"
              }
            }
          }
        }
      end

      it { should eql(expected_hash) }

      context "when preserve attributes is true" do

        let(:options) { { :preserve_attributes => true } }
        let(:expected_hash) do
          {
            "Park.Animal" => {
              "type"   => "mutant", 
              "friends"=> {
                "type" => "Hash", 
                "__content__" => {
                  "i" => "5", 
                  "Park.Animal"=>{"type"=>"dog"}
                }
              }
            }
          }
        end

        it { should eql(expected_hash) }
      end
    end
  end
end
