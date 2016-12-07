class User < ApplicationRecord
  attr_accessor :remember_token
  
  has_many :posts
  
  before_create :create_user_token
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false } 
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def create_user_token
    self.remember_digest = User.digest(User.new_remember_token)
  end
  
end
