class NewsSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers  
  attributes :id, :title, :body, :image_url, :links, :date, :created_at
  
  def image_url
    if object.image.attached?
      url_for(object.image)
    end
  end
end

