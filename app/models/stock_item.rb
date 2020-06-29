class StockItem < ApplicationRecord
  belongs_to :product
  belongs_to :store

  validates :qty, presence: { message: "Quantity required." }

  def deactivate
    self.deleted_at = DateTime.now
    save
  end
end
