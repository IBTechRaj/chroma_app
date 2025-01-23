FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password_digest { "password123" } # Adjust this if you use secure password features
    # password_confirmation { "password123" } # Adjust this if you use secure password features
  end
end
