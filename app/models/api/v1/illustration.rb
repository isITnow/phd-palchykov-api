module Api
  module V1  
    class Api::V1::Illustration < ApplicationRecord
      belongs_to :research
      has_one_attached :schema
      
      validates :description, :schema, presence: true
    end
  end
end
