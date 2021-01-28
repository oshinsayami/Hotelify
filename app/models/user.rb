class User < ApplicationRecord
    has_many :ratings
    has_many :hotels, through: :ratings

    validates :name, presence: true
    validates :email, uniqueness: true, presence:true
    
    has_secure_password

    def self.create_from_omnioath(auth)
        self.find_or_create_by(uid: auth[:uid], provider: auth[:provider]) do |u|
            u.name = auth["info"]["name"]
            u.email = auth["info"]["email"]
            u.password = SecureRandom.hex(13)
        end
    end

end
