class Api::V1::News < ApplicationRecord
  validates :title, presence: true
  
  has_one_attached :image
end

