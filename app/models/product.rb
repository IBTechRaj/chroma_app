class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :cart_items

  validates :name, :price, :category_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
