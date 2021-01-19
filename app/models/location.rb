class Location < ApplicationRecord
    has_many :hotels
    validates :state, :city, uniqueness: true
end
