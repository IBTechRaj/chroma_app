# spec/factories/orders.rb
FactoryBot.define do
  factory :order do
    total_price { Faker::Commerce.price(range: 10..1000) }
    status { %w[pending completed cancelled].sample }
    association :user, factory: :user
  end
end
