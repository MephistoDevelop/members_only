class User < ApplicationRecord
  attr_accessor :remember_token,:activation_token
  validates :name,presence:true
  validates :email,presence:true
  has_secure_password

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    #self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(User.new_token))
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
