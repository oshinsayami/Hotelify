class Hotel < ApplicationRecord
  belongs_to :location
  belongs_to :user
  has_many :ratings, dependent: :destroy
  has_many :users, through: :ratings

  scope :low_to_high_price, -> {order("price")}
  scope :high_to_low_price, -> {order("price DESC")}
  scope :most_rated, ->{joins(:ratings).group('hotels.id').order('count(hotels.id) desc')}
  

  validates :name, :price, presence: true
  validate :dublicate_attributes, on: :create
  

  def location_attributes=(attributes)
    if !attributes[:city].blank? && !attributes[:state].blank?
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

  def self.search(params)
    joins(:location).where("LOWER(hotels.name) LIKE :term OR LOWER(locations.city) LIKE :term OR LOWER(locations.state) LIKE :term", term: "%#{params}%")

  end


  

end
