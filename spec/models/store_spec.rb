require "rails_helper"

describe Store, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name).with_message("Store name required.") }
    it { is_expected.to validate_presence_of(:address).with_message("Store address required.") }
  end

  describe "methods" do
    let!(:store) { create(:store) }
    describe "#deactivate" do
      it "should return done" do
        expect(store.deactivate).to be true
      end
    end
  end
end
