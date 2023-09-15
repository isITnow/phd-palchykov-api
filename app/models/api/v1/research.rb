module Api
  module V1
    class Api::V1::Research < ApplicationRecord
      has_many :illustrations, dependent: :destroy
    end
  end
end
