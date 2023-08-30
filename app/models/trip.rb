class Trip < ApplicationRecord
  belongs_to :planner, class_name: 'User'
  belongs_to :tripper, class_name: 'User'
  has_many :destinations
  has_many :messages
  validates :title, presence: true
  validates :image_url, presence: true
  validates :comment, presence: true
  validates :planner_id, presence: true
end
