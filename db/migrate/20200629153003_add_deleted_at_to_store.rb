class AddDeletedAtToStore < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :deleted_at, :datetime
  end
end
