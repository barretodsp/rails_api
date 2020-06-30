RSpec.describe StoreService, type: :model do
  describe "methods" do
    let!(:prod) { FactoryBot.build(:store) }
    let!(:store_ex) { create(:store) }
    let!(:update_params) { { name: "Updated Name" } }

    describe "#create" do
      it "return created" do
        resp = StoreService.create prod
        expect(resp).to eq({ notice: "Store created!" })
      end
    end

    describe "#get_by_id" do
      it "return object" do
        resp = StoreService.get_by_id store_ex.id
        # expect(resp).to include :notice
        expect(resp).to eq({ notice: store_ex })
      end
    end

    describe "#update" do
      it "return updated" do
        resp = StoreService.update store_ex.id, update_params
        expect(resp).to eq({ notice: "Store updated!" })
      end

      it "return invalid" do
        resp = StoreService.update "abc", update_params
        expect(resp).to eq({ alert: "Store invalid." })
      end
    end

    describe "#delete" do
      it "return deleted" do
        resp = StoreService.delete store_ex.id
        expect(resp).to eq({ notice: "Store deleted!" })
      end

      it "return invalid" do
        resp = StoreService.delete "abc"
        expect(resp).to eq({ alert: "Store invalid." })
      end
    end
  end
end
