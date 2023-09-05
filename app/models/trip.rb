class Trip < ApplicationRecord
  belongs_to :planner, class_name: 'User', foreign_key: 'planner_id'
  belongs_to :tripper, class_name: 'User', foreign_key: 'tripper_id'
  has_many :trip_destinations, dependent: :destroy
  has_many :destinations, through: :trip_destinations
  has_many :messages, dependent: :destroy
  validates :title, presence: true
  validates :city, presence: true
  validates :comment, presence: true
  validates :planner_id, presence: true
  belongs_to :trip, optional: true
  has_many :trips, dependent: :destroy
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :destinations

  has_one_attached :photo

  STYLES = ["cultural", "adventure", "romantic", "gastronomic", "ecotourism", "luxury", "accessible", "party", "humanitarian"]

  include PgSearch::Model
  pg_search_scope :search_by_title,
    against: [ :title ],
    using: {
      tsearch: { prefix: true }
    }

  def ordered_tripdestinations
    trip_destinations.order(:position)
  end
end
