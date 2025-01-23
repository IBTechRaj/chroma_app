class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  validates :user, presence: true
 validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: %w[active completed abandoned] }

  def add_item(product, quantity = 1)
    cart_item = cart_items.find_or_initialize_by(product: product)
    cart_item.quantity += quantity
    cart_item.price = product.price
    cart_item.save
    calculate_total
  end
  
  def calculate_total
    self.total_price = cart_items.sum { |item| item.quantity * item.price }
  end
end