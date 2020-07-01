require "rails_helper"

RSpec.describe Product, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name).with_message("Product name required.") }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0).with_message("Invalid price.") }
  end

  describe "methods" do
    let!(:product) { create(:product) }
    describe "#deactivate" do
      it "should return done" do
        expect(product.deactivate).to be true
      end
    end
  end
end
