class Hotel < ApplicationRecord
  belongs_to :location
  belongs_to :user
  has_many :ratings
  has_many :users, through: :ratings

  scope :low_to_high_price, -> {order("price")}
  scope :high_to_low_price, -> {order("price DESC")}

  validates :name, :price, presence: true
  validate :dublicate_attributes
  

  def location_attributes=(attributes)
    # byebug
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
    where("LOWER(name) LIKE ?", "%#{params}%")
  end


end
