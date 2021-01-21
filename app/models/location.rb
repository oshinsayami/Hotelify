class Location < ApplicationRecord
    has_many :hotels
    validates :city, uniqueness: {scope: :state}, presence: true
    validates :state, presence: true
end
