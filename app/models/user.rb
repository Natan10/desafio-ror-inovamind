class User
  include Mongoid::Document
  include ActiveModel::SecurePassword 
  has_secure_password

  field :email, type: String
  field :password_digest, type: String

  validates :email, presence: true, uniqueness: true,
   format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  
  validates :password,presence: true, :on => :create

end
