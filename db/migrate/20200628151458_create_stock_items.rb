class CreateStockItems < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_items do |t|
      t.references :product, foreign_key: true, null: false
      t.references :store, foreign_key: true, null: false
      t.integer :qty, null: false

      t.timestamps
    end
  end
end
