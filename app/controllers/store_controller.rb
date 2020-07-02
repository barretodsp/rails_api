class StoreController < ApplicationController
  before_action :set_store_by_params, only: :add

  def get_by_id
    resp = StoreService.get_by_id(params[:id])
    resp_message_with_data(resp)
  end

  def add
    resp = StoreService.create(@store)
    resp_message_default(resp)
  end

  def update
    resp = StoreService.update(params[:id], store_params)
    resp_message_default(resp)
  end

  def delete
    resp = StoreService.delete(params[:id])
    resp_message_default(resp)
  end

  private

  def store_params
    params.permit(:name, :address)
  end

  def set_store_by_params
    @store = Store.new(store_params)
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
