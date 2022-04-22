class Admin
  include Mongoid::Document
  include ActiveModel::SecurePassword 
  
  field :password_digest, type: String
  has_secure_password
end
