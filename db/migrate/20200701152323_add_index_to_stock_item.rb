class AddIndexToStockItem < ActiveRecord::Migration[5.2]
  def change
    add_index :stock_items, [:product_id, :store_id], :unique => true
  end
end
