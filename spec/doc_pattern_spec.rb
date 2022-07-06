# frozen_string_literal: true

RSpec.describe DocPattern do
  let(:valid_path) { "lib/json/valids/single_line.json" }
  subject { DocPattern.new(valid_path) }

  it "valid sub keys" do
    expect(subject.valid_sub_keys).to eq %w[separator field_type field_pattern line_length
                                            minimal_elements max_elements]
  end

  describe "#valid?" do
    [
      "lib/json/valids/single_line.json"
    ].each do |directory|
      subject { DocPattern.new(directory) }
      it { is_expected.to be_valid }
    end
  end

  describe "#invalid?" do
    [
      "lib/json/invalids/ambigous_rule.json",
      "lib/json/invalids/empty.json"
    ].each do |directory|
      subject { DocPattern.new(directory) }
      it { is_expected.to be_invalid }
    end
  end

  describe "#storage_doc" do
    describe "default document" do
      it "is expected to return all lines" do
        subject.storage_doc("lib/json/doc/default.txt")

        expected_storage = {
          line1: {
            element1: "first line",
            element2: "first line"
          },
          line2: {
            element1: "second line",
            element2: "second line"
          }
        }

        expect(subject.lines).to eq expected_storage
      end
    end

    describe "invalid documents" do
      describe "empty document" do
        it "should return an empty document error" do
          expect { subject.storage_doc("lib/json/doc/invalid.txt") }.to raise_error("Empty file")
        end
      end
    end
  end
end
