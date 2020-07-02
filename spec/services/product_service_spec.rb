RSpec.describe ProductService, type: :model do
  describe "methods" do
    let!(:prod) { FactoryBot.build(:product) }
    let!(:product) { create(:product) }
    let!(:update_params) { { name: "Updated Name" } }

    describe "#create" do
      it "return created" do
        resp = ProductService.create prod
        expect(resp).to eq({ notice: "Product created!" })
      end
    end

    describe "#get_by_id" do
      it "return object" do
        resp = ProductService.get_by_id product.id
        expect(resp).to eq({ notice: product })
      end
    end

    describe "#update" do
      it "return updated" do
        resp = ProductService.update product.id, update_params
        expect(resp).to eq({ notice: "Product updated!" })
      end

      it "return invalid" do
        resp = ProductService.update "abc", update_params
        expect(resp).to eq({ alert: "Invalid request.", status: 400 })
      end
    end

    describe "#delete" do
      it "return deleted" do
        resp = ProductService.delete product.id
        expect(resp).to eq({ notice: "Product deleted!" })
      end

      it "return invalid" do
        resp = ProductService.delete "abc"
        expect(resp).to eq({ alert: "Invalid request.", status: 400 })
      end
    end
  end
end
