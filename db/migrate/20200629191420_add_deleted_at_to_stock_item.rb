class AddDeletedAtToStockItem < ActiveRecord::Migration[5.2]
  def change
    add_column :stock_items, :deleted_at, :datetime
  end
end
