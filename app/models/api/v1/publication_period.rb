module Api
  module V1
    class Api::V1::PublicationPeriod < ApplicationRecord
      has_many :publications, dependent: :destroy
      
      validates :title, presence: true, uniqueness: true
    end
  end
end
