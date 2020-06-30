require "rails_helper"

RSpec.describe ProductController, type: :controller do
  let!(:product) { create(:product) }
  let(:valid_attributes) { attributes_for(:product) }
  let(:invalid_attributes) { { name: nil, price: nil } }
  let(:price_value) { 8080.22 }
  let(:price_invalid) { -111.22 }
  let(:name_value) { "Update Test" }

  describe "POST #add" do
    context "With valid params" do
      it "create Product" do
        expect do
          post :add, params: valid_attributes
        end.to change(Product, :count).by(1)
      end

      it "return success" do
        post :add, params: valid_attributes
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(({ "message": "Product created!" }).to_json)
      end
    end

    context "With invalid params" do
      it "not create product" do
        expect do
          post :add, params: invalid_attributes
        end.to change(Product, :count).by(0)
      end

      it "return error" do
        post :add, params: invalid_attributes
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq(({ "error": "Product name required., Invalid price." }).to_json)
      end
    end
  end

  describe "POST #get_by_id" do
    context "With valid params" do
      before do
        post :get_by_id, params: { id: product.id }
      end
      it "return Product" do
        expect(response.body).to eq({ "data": product }.to_json)
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
        post :update, params: { id: product.id, price: price_value, name: name_value }
      end
      it "updates the price" do
        product.reload
        expect(product.price).to eq price_value
      end
      it "update the name" do
        product.reload
        expect(product.name).to eq name_value
      end
      it "return success" do
        expect(response).to have_http_status(:ok)
      end
      it "return success message " do
        expect(response.body).to eq(({ "message": "Product updated!" }).to_json)
      end
    end

    context "with invalid params" do
      before do
        post :update, params: { id: product.id, price: price_invalid }
      end
      it "not update the price" do
        product.reload
        expect(product.price).to_not eq price_invalid
      end
      it "return bad request" do
        product.reload
        expect(response).to have_http_status(:bad_request)
      end
      it "return error message " do
        expect(response.body).to eq(({ "error": "Invalid price." }).to_json)
      end
    end
  end

  describe "POST #delete" do
    context "with valid params" do
      before do
        post :delete, params: { id: product.id }
      end
      it "update deleted_at" do
        product.reload
        expect(product.deleted_at).to_not eq nil
      end
      it "return success" do
        expect(response).to have_http_status(:ok)
      end
      it "return success message " do
        expect(response.body).to eq(({ "message": "Product deleted!" }).to_json)
      end
    end

    context "with invalid params" do
      before do
        post :delete, params: { id: "abc" }
      end
      it "not update deleted_at" do
        product.reload
        expect(product.deleted_at).to eq nil
      end
      it "return bad request" do
        product.reload
        expect(response).to have_http_status(:bad_request)
      end
      it "return error message " do
        expect(response.body).to eq(({ "error": "Product invalid." }).to_json)
      end
    end
  end
end
