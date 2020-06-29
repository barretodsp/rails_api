class StockItemService < ApplicationService
  def self.create(stock_item)
    success_resp = { notice: "Stock Item created!", status: :ok }
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
    success_resp = { notice: "Stock Item updated!", status: :ok }
    transacional(success_resp) do
      stock_item = get_valid(id)
      if stock_item && valid_qty?(params[:qty])
        stock_item.lock!
        stock_item.qty = stock_item.qty + params[:qty]
        raise Exception.new(stock_item.errors.values.join(", ")) unless stock_item.save
      else
        raise Exception.new("Stock Item or qty invalid.")
      end
    end
  end

  def self.delete_qty(id, params)
    success_resp = { notice: "Stock Item updated!", status: :ok }
    transacional(success_resp) do
      stock_item = get_valid(id)
      if stock_item && valid_qty?(params[:qty])
        stock_item.lock!
        stock_item.qty = stock_item.qty - params[:qty]
        raise Exception.new(stock_item.errors.values.join(", ")) unless stock_item.save
      else
        raise Exception.new("Stock Item or qty invalid.")
      end
    end
  end

  def self.delete(id)
    success_resp = { notice: "Stock Item deleted!", status: :ok }
    transacional(success_resp) do
      stock_item = get_valid(id)
      if stock_item
        raise Exception.new(stock_item.errors.values.join(", ")) unless stock_item.deactivate()
      else
        raise Exception.new("Invalid.")
      end
    end
  end

  private

  def self.get_valid(id)
    return nil if !(id && id.is_a?(Integer))
    StockItem.find_by_id(id)
  end

  def self.valid_qty?(qty)
    (qty && qty.is_a?(Integer))
  end
end
