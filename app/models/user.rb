class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  
  field :email, type: String
  field :password_digest, type: String
  
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  
  validates :password, presence: true, on: :create
  has_secure_password
end
