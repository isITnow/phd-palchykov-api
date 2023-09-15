module Api
  module V1  
    class Api::V1::ColleagueSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers  
      attributes :id, :name, :position, :phone, :email, :photo_url, :created_at
      
      def photo_url
        if object.photo.attached?
          rails_blob_url(object.photo, only_path: true)
        end
      end
    end
  end
end
