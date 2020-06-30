FactoryBot.define do
  factory :stock_item do
    association :product, factory: :product
    association :store, factory: :store
    qty { 50 }
  end
end
