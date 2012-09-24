shared_examples_for "an XML parser" do

  before do
    begin
      Eggnog::XML.parser = parser
    rescue LoadError
      pending "Parser #{parser} couldn't be loaded"
    end
  end

  let(:preserve_attributes) { { :preserve_attributes => true } }

  describe ".parse" do
    let(:xml)     { '' }
    let(:options) { {} }

    subject { Eggnog::XML.parse(xml, options) }

    context "a blank string" do
      let(:xml) { '' }
      let(:expected) { {} }
      it { should eql(expected) }
    end

    context "a whitespace string" do
      let(:xml) { ' ' }
      let(:expected) { {} }
      it { should eql(expected) }
    end

    context "an invalid XML document" do
      let(:xml) { fixture_file("invalid.xml") }
      it "raises a Eggnog::XML::ParseError" do
        lambda { subject }.should raise_error(Eggnog::XML::ParseError)
      end
    end

    context "a valid XML document" do
      let(:xml) { fixture_file("valid.xml") }
      let(:expected) do
        { "foo" => "bar" }
      end
      it { should eql(expected) }

      context "with CDATA" do
        let(:xml) { fixture_file("cdata.xml") }
        let(:expected) do
          { "user" => "John Doe" }
        end

        it { should eql(expected) }
      end

      context "with content" do
        let(:xml) { fixture_file("content.xml") }
        let(:expected) do
          { "user" => "John Doe" }
        end
        it { should eql(expected) }
      end

      context "with an attribute" do
        let(:xml) { fixture_file("attribute.xml") }

        context "when preserve_attributes = false" do
          let(:expected) do
            { "user" => { } }
          end
          it { should eql(expected) }
        end

        context "when preserve attributes = true" do
          let(:options) { preserve_attributes }
          let(:expected) do
            { "user" => { "name" => "John Doe" } }
          end
          it { should eql(expected) }
        end
      end

      context "with multiple attributes" do
        let(:xml) { fixture_file("multiple_attributes.xml") }

        context "when preserve_attributes = false" do
          let(:expected) do
            { "user" => {} }
          end
          it { should eql(expected) }
        end

        context "when preserve_attributes = true" do
          let(:options) { preserve_attributes }
          let(:expected) do
            { "user" => { "name" => "John Doe", "screen_name" => "john_doe" } }
          end
          it { should eql(expected) }
        end
      end

      context "when symbolize_keys = true" do
        let(:xml)     { fixture_file("symbolize_keys.xml") }
        let(:options) { { :symbolize_keys => true } }
        let(:expected) do
          { 
            :user => {
              :name    => "John Doe",
              :age     => "50",
              :zipcode => "98122"
            } 
          }
        end
        it { should eql(expected)}
      end

    end # context 'valid xml'
  end # .parse
end # shared_examples
