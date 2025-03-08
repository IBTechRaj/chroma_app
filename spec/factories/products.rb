FactoryBot.define do
  factory :product do
    product_name { "Sample Product" }
    brand_name { "BrandX" }
    category { "Electronics" }
    description { "A high-quality product" }
    price { 100.50 }
    selling_price { 90.00 }
    product_image { ["image1.jpg", "image2.jpg"] } # Assuming it's stored as an array of URLs/paths
    association :category, factory: :category
  end
end
