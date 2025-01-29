class User < ApplicationRecord
    has_secure_password
    has_one_attached :profile_pic
  has_many :orders
  has_many :carts

  ROLES =  %w[admin supervisor customer].freeze

  validates :role, inclusion: { in: ROLES }

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  #  validates :profile_pic, format: { with: /\Ahttps?:\/\/.*\.(jpg|jpeg|png|gif)\z/i, message: 'must be a valid image URL' }, allow_blank: true

    def admin?
    role == 'admin'
  end

  def supervisor?
    role == 'supervisor'
  end

  def customer?
    role == 'customer'
  end

  def get_profile_pic_url
      Rails.application.routes.url_helpers.url_for(profile_pic) if profile_pic.attached?
    end
end
