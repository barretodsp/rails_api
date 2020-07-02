RSpec.describe ProductService, type: :model do
  describe "methods" do
    let!(:stock) { FactoryBot.build(:stock_item) }
    let!(:stock_item) { create(:stock_item) }
    let!(:qty) { { qty: 7 } }
    let!(:invalid_qty) { { qty: -1 } }

    describe "#create" do
      it "return created" do
        resp = StockItemService.create stock
        expect(resp).to eq({ notice: "Stock Item created!" })
      end
    end

    describe "#get_by_id" do
      it "return object" do
        resp = StockItemService.get_by_id stock_item.id
        expect(resp).to eq({ notice: stock_item })
      end
    end

    describe "#add_qty" do
      it "return updated" do
        resp = StockItemService.add_qty stock_item.id, qty
        expect(resp).to eq({ notice: "Stock Item updated!" })
      end

      it "return invalid" do
        resp = StockItemService.add_qty stock_item, invalid_qty
        expect(resp).to eq({ alert: "Stock Item or qty invalid.", status: 400 })
      end
    end

    describe "#delete_qty" do
      it "return updated" do
        resp = StockItemService.delete_qty stock_item.id, qty
        expect(resp).to eq({ notice: "Stock Item updated!" })
      end

      it "return invalid" do
        resp = StockItemService.delete_qty stock_item, invalid_qty
        expect(resp).to eq({ alert: "Stock Item or qty invalid.", status: 400 })
      end

      it "return invalid by id" do
        resp = StockItemService.delete_qty stock_item.id, { qty: "abc" }
        expect(resp).to eq({ alert: "Stock Item or qty invalid.", status: 400 })
      end
    end

    describe "#delete" do
      it "return deleted" do
        resp = StockItemService.delete stock_item.id
        expect(resp).to eq({ notice: "Stock Item deleted!" })
      end

      it "return invalid" do
        resp = StockItemService.delete "abc"
        expect(resp).to eq({ alert: "Invalid request.", status: 400 })
      end
    end
  end
end
