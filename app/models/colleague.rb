class Colleague < ApplicationRecord
  has_one_attached :photo
  
  validates :name, :position, presence: true, length: { minimum: 5 }
  validates :photo, presence: true
end

