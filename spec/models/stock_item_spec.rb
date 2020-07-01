require "rails_helper"

RSpec.describe StockItem, type: :model do
  let(:stock_item) { FactoryBot.build(:stock_item) }
  subject { stock_item }

  describe "associations" do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:store) }
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:qty).is_greater_than(0).with_message("Quantity invalid.") }
    it { is_expected.to validate_uniqueness_of(:product_id).scoped_to(:store_id).with_message("The product already exists in the store.") }
  end

  describe "methods" do
    let!(:stock_item) { create(:stock_item) }
    describe "#deactivate" do
      it "should return done" do
        expect(stock_item.deactivate).to be true
      end
    end
  end
end
