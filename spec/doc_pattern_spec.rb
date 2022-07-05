# frozen_string_literal: true

RSpec.describe DocPattern do
  subject { DocPattern.new }

  it "valid sub keys" do
    expect(DocPattern::VALID_SUB_KEYS).to eq %w[separator field_type field_pattern line_length
                                                minimal_elements max_elements]
  end

  describe "#until_line_range" do
    context "when there is a range" do
      valid_key = 'line_1..3'

      it 'should be a until line' do
        expect(subject.until_line?(valid_key)).to be_truthy
      end
      it 'until line should had a range' do
        expect(subject.until_line_range(valid_key)).to eq [1,2,3]
      end
    end

    context "when there is no range" do
      invalid_key = 'line_1'

      it 'should not be a until line' do
        expect(subject.until_line?(invalid_key)).to be_falsey
      end
      it 'single line should not had a range' do
        expect(subject.until_line_range(invalid_key)).to eq []
      end 
    end
  end

  describe "#valid?" do
    it "should valid if not had broken rules" do
      [
        "lib/json/valids/single_line.json"
      ].each do |directory|
        subject.read_json(directory)
        expect(subject).to be_valid
      end
    end
  end

  describe "#invalid?" do
    it "should be valid if not had broken rules" do
      [
        "lib/json/invalids/ambigous_rule.json",
        "lib/json/invalids/empty.json"
      ].each do |directory|
        subject.read_json(directory)
        expect(subject).to be_invalid
      end
    end
  end
end
