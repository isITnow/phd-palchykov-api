module Api
  module V1
    class Api::V1::Post < ApplicationRecord
      has_many :comments, dependent: :destroy
      
      validates :body, presence: true
    end
  end
end
