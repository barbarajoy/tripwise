class Destination < ApplicationRecord
  belongs_to :trip
  validates :longitude, presence: true
  validates :longitude, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :position, presence: true
end
