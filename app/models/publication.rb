class Publication < ApplicationRecord
  belongs_to :publication_period

  has_one_attached :cover
  has_one_attached :abstract

  validates :title, :source, :source_url, :year, presence: true
end
