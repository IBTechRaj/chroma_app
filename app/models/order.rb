class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :user, :total_price, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending completed cancelled] }

  def calculate_total
    order_items.sum { |item| item.price * item.quantity }
  end
end