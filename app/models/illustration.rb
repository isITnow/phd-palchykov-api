class Illustration < ApplicationRecord
  belongs_to :research
  
  has_one_attached :schema
  
  validates :description, :schema, presence: true
  validates :sequence_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
end

