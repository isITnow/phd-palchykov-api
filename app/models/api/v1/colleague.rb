class Api::V1::Colleague < ApplicationRecord
  has_one_attached :photo
  
  validates :name, :photo, :position, presence: true
end

