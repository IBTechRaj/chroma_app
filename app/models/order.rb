class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  validates :user_id, :total_price, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
end