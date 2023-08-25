class PublicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers  
  attributes :id, :title, :source, :psource_url, :authors, :cover_url, :abstract_url, :created_at

  def cover_url
    if object.cover.attached?
      rails_blob_url(object.cover, only_path: true)
    end
  end

  def abstract_url
    if object.abstract.attached?
      rails_blob_url(object.cabstract, only_path: true)
    end
  end
end
