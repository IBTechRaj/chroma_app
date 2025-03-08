class ProductSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :product_name, :brand_name, :category, :description, :price, :selling_price, :created_at, :updated_at

  # If product_image is stored as an array of URLs in JSON, return it directly
  attribute :product_image do |product|
    product.product_image.is_a?(Array) ? product.product_image : []
  end
end
