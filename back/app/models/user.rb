class User < ApplicationRecord
    belongs_to :address, optional: true  
    has_secure_password 
    has_one :address
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true
    validates :password, length: { minimum: 6 }, allow_nil: true  
  
    validates :user_type, inclusion: { in: ['seller', 'user'], message: "%{value} não é um tipo válido" }
  end
