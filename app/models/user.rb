class User < ApplicationRecord
    has_many :ratings
    has_many :hotels, through: :ratings

    validates :email, uniqueness: true, presence:true
    
    has_secure_password

    def self.login_by_google(auth)
        self.find_or_create_by(email: auth[:info][:email]) do |u|
            u.name = auth["info"]["name"]
            u.password = SecureRandom.hex(13)
        end
    end

end
