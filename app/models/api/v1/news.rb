module Api
  module V1
    class Api::V1::News < ApplicationRecord
      validates :title, presence: true
      
      has_one_attached :image
    end
  end
end
