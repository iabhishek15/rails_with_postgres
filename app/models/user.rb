class User < ApplicationRecord
  has_one_attached :profile_image

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password ,presence: true,confirmation: true, length: {in: 4..20}, on: :password_setup
  validate :acceptable_image

  attr_accessor :password

  validates_with UserValidate

  def acceptable_image
  end

  # def acceptable_image
  #   #checking if present or not
  #   return unless profile_image.attached?
  #   #checking the max size
  #   unless profile_image.byte_size <= 10.megabyte
  #    errors.add(:profile_image, "is too big")
  #  end
  #  #checking for jpeg and png
  #  acceptable_types = ["image/jpeg", "image/png"]
  #  unless acceptable_types.include?(profile_image.content_type)
  #     errors.add(:profile_image, "must be a JPEG or PNG")
  #   end
  # end





  before_save :creating_password

  def creating_password
    if password
      self.hashed_password = User.encrypt(password)
    end
  end

  def self.encrypt(password_encrypt)
    Digest::SHA1.hexdigest(password_encrypt)
  end
end
