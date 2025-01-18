class User < ApplicationRecord
    has_secure_password
  has_many :orders
  has_many :carts

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
