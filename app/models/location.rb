class Location < ApplicationRecord
    has_many :hotels
    validates :city, :state, presence: true, uniqueness: true
end
