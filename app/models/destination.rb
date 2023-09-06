class Destination < ApplicationRecord
  has_many :trip_destinations
  has_many :trips, through: :trip_destinations
  validates :longitude, presence: true
  validates :longitude, presence: true
  validates :address, presence: true
  validates :description, presence: true
  delegate :position, to: :trip_destinations
end
