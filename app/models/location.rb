class Location < ApplicationRecord
    has_many :hotels
    validates :city, uniqueness: {scope: :state}, presence: true
    validates :state, presence: true

    def city_and_state
        "#{self.city}, #{self.state}"
    end

    
end

