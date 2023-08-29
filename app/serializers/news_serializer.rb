class NewsSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers  
  attributes :id, :title, :body, :links, :date, :image_url, :created_at

  def image_url
    if object.image.attached?
      rails_blob_url(object.image, only_path: true)
    end
  end
end
