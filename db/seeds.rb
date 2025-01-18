# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Clear existing data
Product.destroy_all
Category.destroy_all

# Seed categories
10.times do
  Category.create!(
    name: Faker::Commerce.department
  )
end

# Seed products
categories = Category.all
50.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 0..100.0),
    category_id: categories.sample.id
  )
end

puts "Seeded #{Category.count} categories."
puts "Seeded #{Product.count} products."