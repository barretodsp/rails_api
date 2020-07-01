class StockItem < ApplicationRecord
  belongs_to :product
  belongs_to :store

  validates :qty, numericality: { greater_than: 0, message: "Quantity invalid." }, on: [:create, :update]
  validates :product_id, uniqueness: { scope: :store_id, message: "The product already exists in the store." }

  def deactivate
    self.deleted_at = DateTime.now
    save
  end
end
