# frozen_string_literal: true

RSpec.describe DocPattern do
  subject { DocPattern.new }

  it 'valid sub keys should be' do
    expect(DocPattern::VALID_SUB_KEYS).to eq ["separator", "field_type", "field_pattern", "line_length", "minimal_elements", "max_elements"]
  end

  describe '#valid?' do 
    it 'should valid if not had broken rules' do
      [
        'lib/json/valids/single_line.json'
      ].each do |directory|
        subject.read_json(directory)
        expect(subject).to be_valid
      end
    end
  end

  describe '#invalid?' do 
    it 'should be valid if not had broken rules' do
      [
        'lib/json/invalids/ambigous_rule.json',
        'lib/json/invalids/empty.json'
      ].each do |directory|
        subject.read_json(directory)
        expect(subject).to be_invalid
      end
    end
  end
end
