class Trip < ApplicationRecord
  belongs_to :planner, class_name: 'User'
  belongs_to :tripper, class_name: 'User'
  has_many :trip_destinations, dependent: :destroy
  has_many :destinations, through: :trip_destinations
  has_many :messages, dependent: :destroy
  validates :title, presence: true
  validates :city, presence: true
  validates :image_url, presence: true
  validates :comment, presence: true
  validates :planner_id, presence: true
  belongs_to :trip, optional: true
  has_many :trips, dependent: :destroy
  has_many :messages, dependent: :destroy


  include PgSearch::Model
  pg_search_scope :search_by_title,
    against: [ :title ],
    using: {
      tsearch: { prefix: true }
    }
end
