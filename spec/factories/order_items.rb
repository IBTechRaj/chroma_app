# spec/factories/order_items.rb
FactoryBot.define do
  factory :order_item do
    price { Faker::Commerce.price(range: 1..100) }
    quantity { rand(1..10) }
    association :order
    association :product
  end
end
