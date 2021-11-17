class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: {minimum: 4}


  attr_accessor :password
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
