class TripDestination < ApplicationRecord
  belongs_to :trip
  belongs_to :destination
  validates :position, presence: true
  # delegate :title, to: :destination
  # delegate :title, to: :trip, prefix: true
end
