require "rails_helper"

RSpec.describe StockItemController, type: :controller do
  let(:up_qty) { 7 }
  let(:down_qty) { 4 }
  let(:qty_default) { 50 }
  let(:invalid_qty) { -1 }
  let(:negative_qty) { -60 }
  let!(:product) { create(:product) }
  let!(:store_ex) { create(:store) }
  let!(:stock_item) { create(:stock_item) }
  let(:valid_attributes) { { product_id: product.id, store_id: store_ex.id, qty: qty_default } }
  let(:invalid_attributes) { { product_id: product.id, store_id: store_ex.id, qty: nil } }

  describe "POST #add" do
    context "With valid params" do
      it "create StockItem" do
        expect do
          post :add, params: valid_attributes
        end.to change(StockItem, :count).by(1)
      end

      it "return success" do
        post :add, params: valid_attributes
        expect(response).to have_http_status(:ok)
      end

      it "return success message " do
        post :add, params: valid_attributes
        expect(response.body).to eq(({ "message": "Stock Item created!" }).to_json)
      end
    end

    context "With invalid params" do
      it "not create store" do
        expect do
          post :add, params: invalid_attributes
        end.to change(StockItem, :count).by(0)
      end

      it "return error" do
        post :add, params: invalid_attributes
        expect(response).to have_http_status(:bad_request)
      end

      it "return error message" do
        post :add, params: invalid_attributes
        expect(response.body).to eq(({ "error": "Quantity invalid." }).to_json)
      end
    end
  end

  describe "POST #get_by_id" do
    context "With valid params" do
      before do
        post :get_by_id, params: { id: stock_item.id }
      end
      it "return StockItem" do
        expect(response.body).to eq({ "data": stock_item }.to_json)
      end

      it "return success" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "With invalid params" do
      before do
        post :get_by_id, params: { id: "abc" }
      end

      it "return error" do
        expect(response).to have_http_status(:bad_request)
      end

      it "return error message" do
        expect(response.body).to eq(({ "error": "Invalid request." }).to_json)
      end
    end
  end

  describe "POST #add_qty" do
    context "with valid params" do
      before do
        post :add_qty, params: { id: stock_item.id, qty: up_qty }
      end
      it "increment qty" do
        stock_item.reload
        expect(stock_item.qty).to eq (qty_default + up_qty)
      end
      it "return success" do
        expect(response).to have_http_status(:ok)
      end
      it "return success message " do
        expect(response.body).to eq(({ "message": "Stock Item updated!" }).to_json)
      end
    end

    context "with invalid params" do
      before do
        post :add_qty, params: { id: stock_item.id, qty: invalid_qty }
      end
      it "not increment qty" do
        product.reload
        expect(stock_item.qty).to_not eq (qty_default + invalid_qty)
      end
      it "return bad request" do
        product.reload
        expect(response).to have_http_status(:bad_request)
      end
      it "return error message " do
        expect(response.body).to eq(({ "error": "Stock Item or qty invalid." }).to_json)
      end
    end
  end

  describe "POST #delete_qty" do
    context "with valid params" do
      before do
        post :delete_qty, params: { id: stock_item.id, qty: down_qty }
      end
      it "decrement qty" do
        stock_item.reload
        expect(stock_item.qty).to eq (qty_default - down_qty)
      end
      it "return success" do
        expect(response).to have_http_status(:ok)
      end
      it "return success message " do
        expect(response.body).to eq(({ "message": "Stock Item updated!" }).to_json)
      end
    end

    context "with invalid params" do
      before do
        post :delete_qty, params: { id: stock_item.id, qty: invalid_qty }
      end
      it "not decrement qty" do
        product.reload
        expect(stock_item.qty).to_not eq (qty_default - invalid_qty)
      end
      it "return bad request" do
        product.reload
        expect(response).to have_http_status(:bad_request)
      end
      it "return error message " do
        expect(response.body).to eq(({ "error": "Stock Item or qty invalid." }).to_json)
      end
    end

    context "with decrement could result in negative qty." do
      before do
        post :delete_qty, params: { id: stock_item.id, qty: negative_qty }
      end
      it "not decrement qty" do
        product.reload
        expect(stock_item.qty).to_not eq (qty_default - negative_qty)
      end
      it "return bad request" do
        product.reload
        expect(response).to have_http_status(:bad_request)
      end
      it "return error message " do
        expect(response.body).to eq(({ "error": "Stock Item or qty invalid." }).to_json)
      end
    end
  end

  describe "POST #delete" do
    context "with valid params" do
      before do
        post :delete, params: { id: stock_item.id }
      end
      it "update deleted_at" do
        stock_item.reload
        expect(stock_item.deleted_at).to_not eq nil
      end
      it "return success" do
        expect(response).to have_http_status(:ok)
      end
      it "return success message " do
        expect(response.body).to eq(({ "message": "Stock Item deleted!" }).to_json)
      end
    end

    context "with invalid params" do
      before do
        post :delete, params: { id: "abc" }
      end
      it "not update deleted_at" do
        stock_item.reload
        expect(stock_item.deleted_at).to eq nil
      end
      it "return bad request" do
        stock_item.reload
        expect(response).to have_http_status(:bad_request)
      end
      it "return error message " do
        expect(response.body).to eq(({ "error": "Stock Item invalid." }).to_json)
      end
    end
  end
end
