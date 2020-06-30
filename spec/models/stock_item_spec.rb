require "rails_helper"

describe StockItem, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:store) }
  end

  describe "validations" do
    it { is_expected.to validate_numericality_of(:qty).is_greater_than(0).with_message("Quantity invalid.") }
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
