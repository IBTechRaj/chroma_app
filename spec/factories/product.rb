# spec/factories/products.rb
FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 5..100) }
    # description { Faker::Lorem.paragraph }
    # stock { rand(1..100) }
    association :category
  end
end
