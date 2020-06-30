require "rails_helper"

RSpec.describe StoreController, type: :controller do
  let!(:store_example) { create(:store) }
  let(:valid_attributes) { attributes_for(:store) }
  let(:invalid_attributes) { { name: nil, address: nil } }
  let(:name_value) { "Update Test" }
  let(:address_value) { "Update Address" }

  describe "POST #add" do
    context "With valid params" do
      it "create Store" do
        expect do
          post :add, params: valid_attributes
        end.to change(Store, :count).by(1)
      end

      it "return success" do
        post :add, params: valid_attributes
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(({ "message": "Store created!" }).to_json)
      end
    end

    context "With invalid params" do
      it "not create store" do
        expect do
          post :add, params: invalid_attributes
        end.to change(Store, :count).by(0)
      end

      it "return error" do
        post :add, params: invalid_attributes
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq(({ "error": "Store name required., Store address required." }).to_json)
      end
    end
  end

  describe "POST #get_by_id" do
    context "With valid params" do
      before do
        post :get_by_id, params: { id: store_example.id }
      end
      it "return Store" do
        expect(response.body).to eq({ "data": store_example }.to_json)
      end

      it "return success" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "With invalid params" do
      it "return error" do
        post :get_by_id, params: { id: "abc" }
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq(({ "error": "Invalid request." }).to_json)
      end
    end
  end

  describe "POST #update" do
    context "with valid params" do
      before do
        post :update, params: { id: store_example.id, address: address_value, name: name_value }
      end
      it "updates the address" do
        store_example.reload
        expect(store_example.address).to eq address_value
      end
      it "update the name" do
        store_example.reload
        expect(store_example.name).to eq name_value
      end
      it "return success" do
        expect(response).to have_http_status(:ok)
      end
      it "return success message " do
        expect(response.body).to eq(({ "message": "Store updated!" }).to_json)
      end
    end

    context "with invalid params" do
      before do
        post :update, params: { id: store_example.id, name: nil }
      end
      it "not update the name" do
        store_example.reload
        expect(store_example.name).to_not eq nil
      end
      it "return bad request" do
        store_example.reload
        expect(response).to have_http_status(:bad_request)
      end
      it "return error message " do
        expect(response.body).to eq(({ "error": "Store name required." }).to_json)
      end
    end
  end

  describe "POST #delete" do
    context "with valid params" do
      before do
        post :delete, params: { id: store_example.id }
      end
      it "update deleted_at" do
        store_example.reload
        expect(store_example.deleted_at).to_not eq nil
      end
      it "return success" do
        expect(response).to have_http_status(:ok)
      end
      it "return success message " do
        expect(response.body).to eq(({ "message": "Store deleted!" }).to_json)
      end
    end

    context "with invalid params" do
      before do
        post :delete, params: { id: "abc" }
      end
      it "not update deleted_at" do
        store_example.reload
        expect(store_example.deleted_at).to eq nil
      end
      it "return bad request" do
        store_example.reload
        expect(response).to have_http_status(:bad_request)
      end
      it "return error message " do
        expect(response.body).to eq(({ "error": "Store invalid." }).to_json)
      end
    end
  end
end
