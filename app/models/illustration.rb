class Illustration < ApplicationRecord
  validates :description, presence: true

  belongs_to :research
end
