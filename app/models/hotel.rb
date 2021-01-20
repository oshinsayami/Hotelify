class Hotel < ApplicationRecord
  belongs_to :location
  belongs_to :user
  has_many :ratings
  has_many :users, through: :ratings

  validates :name, :price, presence: true
  validate :dublicate_attributes
  

  def location_attributes=(attributes)
    if !attributes[:city].blank? || !attributes[:state].blank?
      self.location = Location.find_or_create_by(attributes) 
    end
  end

  def dublicate_attributes
    if Hotel.find_by(name: name)
      errors.add(:name, "already exists")
    end
  end

  def self.ordered_hotel
      order(name: :asc)
  end

end
