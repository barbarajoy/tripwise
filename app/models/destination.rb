class Destination < ApplicationRecord
  has_many :trip_destinations, dependent: :destroy
  has_many :trips, through: :trip_destinations
  validates :address, presence: true
  validates :description, presence: true
  delegate :position, to: :trip_destinations
end
