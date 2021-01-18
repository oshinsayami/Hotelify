class Hotel < ApplicationRecord
  belongs_to :location
  belongs_to :user
  has_many :ratings
  has_many :users, through: :ratings

  accepts_nested_attributes_for
end
