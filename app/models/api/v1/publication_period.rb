class Api::V1::PublicationPeriod < ApplicationRecord
  has_many :publications, dependent: :destroy
  
  validates :title, presence: true, uniqueness: true
end

