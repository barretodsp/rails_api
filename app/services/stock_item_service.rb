class StockItemService < ApplicationService
  def self.create(stock_item)
    success_resp = { notice: "Stock Item created!" }
    transacional(success_resp) do
      raise Exception.new(stock_item.errors.values.join(", ")) unless stock_item.save
    end
  end

  def self.get_by_id(id)
    stock_item = get_valid(id)
    return { alert: "Invalid request." } unless stock_item
    { notice: stock_item }
  end

  def self.add_qty(id, params)
    success_resp = { notice: "Stock Item updated!" }
    transacional(success_resp) do
      stock_item = get_valid(id)
      if stock_item && valid_qty?(params[:qty])
        stock_item.lock!
        stock_item.qty = stock_item.qty + params[:qty].to_i
        raise Exception.new(stock_item.errors.values.join(", ")) unless stock_item.save
      else
        raise Exception.new("Stock Item or qty invalid.")
      end
    end
  end

  def self.delete_qty(id, params)
    success_resp = { notice: "Stock Item updated!" }
    transacional(success_resp) do
      stock_item = get_valid(id)
      if stock_item && valid_qty?(params[:qty])
        stock_item.lock!
        stock_item.qty = stock_item.qty - params[:qty].to_i
        raise Exception.new(stock_item.errors.values.join(", ")) unless stock_item.save
      else
        raise Exception.new("Stock Item or qty invalid.")
      end
    end
  end

  def self.delete(id)
    success_resp = { notice: "Stock Item deleted!" }
    transacional(success_resp) do
      stock_item = get_valid(id)
      if stock_item
        raise Exception.new(stock_item.errors.values.join(", ")) unless stock_item.deactivate()
      else
        raise Exception.new("Stock Item invalid.")
      end
    end
  end

  private

  def self.get_valid(id)
    return nil unless id
    StockItem.find_by_id(id)
  end

  def self.valid_qty?(qty)
    qty && qty.to_i > 0
  rescue StandardError
    nil
  end
end
