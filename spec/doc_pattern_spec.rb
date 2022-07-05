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
end
