class StockItemController < ApplicationController
  before_action :set_stock_item_by_params, only: :add

  def get_by_id
    resp = StockItemService.get_by_id(params[:id])
    resp_message_with_data(resp)
  end

  def add
    resp = StockItemService.create(@stock_item)
    resp_message_default(resp)
  end

  def add_qty
    resp = StockItemService.add_qty(params[:id], stock_item_params)
    resp_message_default(resp)
  end

  def delete_qty
    resp = StockItemService.delete_qty(params[:id], stock_item_params)
    resp_message_default(resp)
  end

  def delete
    resp = StockItemService.delete(params[:id])
    resp_message_default(resp)
  end

  private

  def stock_item_params
    params.permit(:product_id, :store_id, :qty)
  end

  def set_stock_item_by_params
    @stock_item = StockItem.new(stock_item_params)
  end

  def resp_message_default(resp)
    if (resp[:notice])
      render json: { message: resp[:notice] }, status: :ok
    else
      render json: { error: resp[:alert] }, status: :bad_request
    end
  end

  def resp_message_with_data(resp)
    if (resp[:notice])
      render json: { data: resp[:notice] }, status: :ok
    else
      render json: { error: resp[:alert] }, status: :bad_request
    end
  end
end
