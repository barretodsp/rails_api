class StockItemService < ApplicationService
  def self.create(stock_item)
    success_resp = { notice: "Stock Item created!" }
    transacional(success_resp) do
      raise ActiveRecord::RecordInvalid.new(stock_item) unless stock_item.save
    end
  end

  def self.get_by_id(id)
    return { alert: "Invalid request.", status: 400 } unless valid_id?(id)
    stock_item = StockItem.find_by_id(id)
    return { alert: "Stock Item not found.", status: 404 } unless stock_item
    { notice: stock_item }
  end

  def self.add_qty(id, params)
    success_resp = { notice: "Stock Item updated!" }
    transacional(success_resp) do
      return { alert: "Stock Item or qty invalid.", status: 400 } unless (valid_id?(id) && valid_qty?(params[:qty]))
      stock_item = StockItem.find_by_id(id)
      return { alert: "Stock Item not found.", status: 404 } unless stock_item
      stock_item.lock!
      stock_item.qty = stock_item.qty + params[:qty].to_i
      raise ActiveRecord::RecordInvalid.new(stock_item) unless stock_item.save
    end
  end

  def self.delete_qty(id, params)
    success_resp = { notice: "Stock Item updated!" }
    transacional(success_resp) do
      return { alert: "Stock Item or qty invalid.", status: 400 } unless (valid_id?(id) && valid_qty?(params[:qty]))
      stock_item = StockItem.find_by_id(id)
      return { alert: "Stock Item not found.", status: 404 } unless stock_item
      stock_item.lock!
      stock_item.qty = stock_item.qty - params[:qty].to_i
      raise ActiveRecord::RecordInvalid.new(stock_item) unless stock_item.save
    end
  end

  def self.delete(id)
    success_resp = { notice: "Stock Item deleted!" }
    transacional(success_resp) do
      return { alert: "Invalid request.", status: 400 } unless valid_id?(id)
      stock_item = StockItem.find_by_id(id)
      return { alert: "Stock Item not found.", status: 404 } unless stock_item
      raise ActiveRecord::RecordInvalid.new(stock_item) unless stock_item.deactivate()
    end
  end

  private

  def self.valid_qty?(qty)
    qty && qty.to_i > 0
  rescue StandardError
    nil
  end
end
