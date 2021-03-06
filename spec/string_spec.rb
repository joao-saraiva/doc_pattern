# frozen_string_literal: true

RSpec.describe String do
  describe "#until_line_range" do
    describe "valid" do
      subject { "line_1..3" }
      context "when there is a range" do
        it "should be a until line" do
          expect(subject.until_line?).to be_truthy
        end

        it "until line should had a range" do
          expect(subject.until_line_range).to eq [1, 2, 3]
        end
      end
    end

    describe "invalid" do
      subject { "line_1" }
      context "when there is no range" do
        it "should not be a until line" do
          expect(subject.until_line?).to be_falsey
        end
        it "single line should not had a range" do
          expect(subject.until_line_range).to eq []
        end
      end
    end
  end

  describe "#multiple_line" do
    describe "when string contains multiple lines" do
      subject { "line_1,2" }
      it { is_expected.to be_multiple_line }
    end

    describe "when string not contains multiple lines" do
      subject { "line_1" }
      it { is_expected.to_not be_multiple_line }
    end
  end
end
