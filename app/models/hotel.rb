class Hotel < ApplicationRecord
  belongs_to :location
  belongs_to :user
  has_many :ratings
  has_many :users, through: :ratings
  

  def location_attributes=(attributes)
    if !attributes[:city].blank? && !attributes[:state].blank?
      self.location = Location.find_or_create_by(attributes) 
    end
  end
end
