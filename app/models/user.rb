class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :trips
  has_many :messages
  validates :first_name, presence: true, format: { with: /\A[a-zA-Z'-]+\z/ }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z'-]+\z/ }
end
