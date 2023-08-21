class PublicationPeriod < ApplicationRecord
  has_many :publications, dependent: :destroy
end
