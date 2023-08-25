class Colleague < ApplicationRecord
  validates :name, :position, presence: true

  has_one_attached :photo
end
