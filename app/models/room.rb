class Room < ApplicationRecord
  has_many :room_messages ,  dependent: :destroy
  belongs_to :user
  validates :name ,  presence: true,  on: :create
end
