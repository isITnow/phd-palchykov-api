class Api::V1::NewsSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers  
  attributes :id, :title, :body, :image_url, :links, :date, :created_at
  
  def image_url
    if object.image.attached?
      rails_blob_url(object.image, only_path: true)
    end
  end
end

