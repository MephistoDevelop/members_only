class User < ApplicationRecord
  attr_accessor :remember_token
  before_create :create_remember_token
  validates :name,presence:true
  validates :email,presence:true
  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end



  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
    self.remember_digest = remember_token
  end
end
