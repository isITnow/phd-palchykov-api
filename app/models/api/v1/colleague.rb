module Api
  module V1
    class Api::V1::Colleague < ApplicationRecord
      has_one_attached :photo
      
      validates :name, :photo, :position, presence: true
    end
  end
end
