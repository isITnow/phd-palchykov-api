class Illustration < ApplicationRecord
  belongs_to :research
  has_one_attached :schema

  validates :description, :schema, presence: true
end
