class Publication < ApplicationRecord
  belongs_to :publication_period
  
  has_one_attached :cover
  has_one_attached :abstract
  
  validates :title, :source, :source_url, :year, presence: true
  validates :sequence_number, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than: 0 }
end
