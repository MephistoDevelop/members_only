class User < ApplicationRecord
  attr_accessor :remember_token
  before_create :create_remember_token
  validates :name,presence:true
  validates :email,presence:true, uniqueness: true
  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token)
  end



  def remember
    self.remember_token = User.new_remember_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_remember_token
    self.remember_token = User.new_remember_token
    self.remember_digest = User.digest(remember_token)
  end
end
