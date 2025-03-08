class Product < ApplicationRecord
  # belongs_to :category
  has_many :order_items
  has_many :cart_items
    
    has_many_attached :product_images  # Active Storage for multiple images

  validates :product_name, :brand_name, :category, :price, :selling_price, presence: true
  validates :price, :selling_price, numericality: { greater_than_or_equal_to: 1 }

  
  def get_product_image_url
      Rails.application.routes.url_helpers.url_for(product_image) if product_image.attached?
    end
end
