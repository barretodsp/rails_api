class Product < ApplicationRecord
  validates :name, presence: { message: "Product name required." }
  validates :price, numericality: { greater_than: 0, message: "Invalid price." }

  def desactivate
    self.deleted_at = DateTime.now
    save
  end
end
