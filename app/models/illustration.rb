class Illustration < ApplicationRecord
  validates :description, presence: true

  belongs_to :research
  has_one_attached :schema
end
