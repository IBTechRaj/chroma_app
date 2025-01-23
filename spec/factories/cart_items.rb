# spec/factories/cart_items.rb
FactoryBot.define do
  factory :cart_item do
    quantity { 1 }
    price { Faker::Commerce.price(range: 5..100) }
    association :cart
    association :product
  end
end
