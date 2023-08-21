class Publication < ApplicationRecord
  belongs_to :publication_period

  validates :title, :source, :source_url, presence: true
end
