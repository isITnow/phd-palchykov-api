class PublicationPeriod < ApplicationRecord
  has_many :publications, dependent: :destroy
  
  validates :title, presence: true, uniqueness: true
end

