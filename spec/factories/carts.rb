# spec/factories/carts.rb
FactoryBot.define do
  factory :cart do
    total_price { 0.0 }
    status { 'active' }
    association :user
  end
end
