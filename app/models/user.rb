class User < ApplicationRecord
    has_many :ratings
    has_many :hotels, through: :ratings

    validates :email, uniqueness: true, presence:true
    
    has_secure_password
end
