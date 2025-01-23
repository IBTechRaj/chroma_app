class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :cart_items
    has_many_attached :images

  validates :name, :price, :category_id, presence: true
  validates :price,numericality: { greater_than: 0 }
end
