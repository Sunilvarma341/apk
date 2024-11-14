class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, length: { minimum: 6 }, allow_nil: true, on: :update
  # before_create :auth_key  

  # def auth_key  
  #   key =  Rails.application.secrets.secret_key_base 
  #   puts "=============== #{key}" 
  # end
end
