class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  validates :stars, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 6} 
  validates :hotel, uniqueness: {scope: :user, message: "was already rated by you"}
end
