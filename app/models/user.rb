class User < ApplicationRecord
    has_secure_password
    has_one_attached :profile_pic
  has_many :orders
  has_many :carts

    # before_save :generate_token

  validates :name, :email, presence: true
  validates :email, uniqueness: true
   validates :profile_pic, format: { with: /\Ahttps?:\/\/.*\.(jpg|jpeg|png|gif)\z/i, message: 'must be a valid image URL' }, allow_blank: true

   private
# def generate_token
#   byebug
#   self.token ||= SecureRandom.hex
# end

  # def acceptable_image
  #   return unless profile_pic.attached?

  #   errors.add(:profile_pic, 'must be less than 5MB') if profile_pic.byte_size > 5.megabytes

  #   acceptable_types = ['image/jpeg', 'image/png', 'image/gif']
  #   errors.add(:profile_pic, 'must be a JPEG, PNG, or GIF') unless acceptable_types.include?(profile_pic.content_type)
  # end
  # def full_name
  #   name
  # end
  
end
