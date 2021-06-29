require "rails_helper"

RSpec.describe Quote, type: :model do
  it { is_expected.to be_mongoid_document }
  it { is_expected.to have_field(:quote).of_type(String) }
  it { is_expected.to have_field(:author).of_type(String) }
  it { is_expected.to have_field(:author_about).of_type(String) }
  it { is_expected.to have_field(:tags).of_type(Array) }
  it { is_expected.to validate_presence_of(:quote) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:author_about) }
  it { is_expected.to validate_presence_of(:tags) }

  describe "create quotes" do
    it "valid params" do
      quote = build(:quote)
      expect(quote.save!).to eq(true)
    end

    it "empty params" do
      quote = described_class.new
      expect {
        quote.save!
      }.to raise_error(Mongoid::Errors::Validations)
    end
  end
end
