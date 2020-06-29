class Store < ApplicationRecord
  validates :name, presence: { message: "Store name required." }
  validates :address, presence: { message: "Address required." }

  def deactivate
    self.deleted_at = DateTime.now
    save
  end
end
