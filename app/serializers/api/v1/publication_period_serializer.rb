module Api
  module V1  
    class Api::V1::PublicationPeriodSerializer < ActiveModel::Serializer
      attributes :id, :title
    end
  end
end
