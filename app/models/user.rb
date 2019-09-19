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
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(String, cost: cost)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    self[:remember_digest] = nil
  end

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
    self.remember_digest = remember_token
  end
end
