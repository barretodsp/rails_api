class ProductController < ApplicationController
  before_action :set_product_by_params, only: :add

  def get_by_id
    resp = ProductService.get_by_id(params[:id])
    resp_message_with_data(resp)
  end

  def add
    resp = ProductService.create(@product)
    resp_message_default(resp)
  end

  def update
    resp = ProductService.update(params[:id], product_params)
    resp_message_default(resp)
  end

  def delete
    resp = ProductService.delete(params[:id])
    resp_message_default(resp)
  end

  private

  def product_params
    params.permit(:name, :price)
  end

  def set_product_by_params
    @product = Product.new(product_params)
  end

  def resp_message_default(resp)
    if (resp[:notice])
      render json: { message: resp[:notice] }, status: :ok
    else
      render json: { error: resp[:alert] }, status: resp[:status] || 500
    end
  end

  def resp_message_with_data(resp)
    if (resp[:notice])
      render json: { data: resp[:notice] }, status: :ok
    else
      render json: { error: resp[:alert] }, status: resp[:status] || 500
    end
  end
end
