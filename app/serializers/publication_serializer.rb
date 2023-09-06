class PublicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers  
  attributes :id, :title, :year, :source, :source_url, :authors, :cover_url, :abstract_url, :publication_period_id, :created_at

  def cover_url
    if object.cover.attached?
      rails_blob_url(object.cover, only_path: true)
    end
  end

  def abstract_url
    if object.abstract.attached?
      rails_blob_url(object.abstract, only_path: true)
    end
  end
end
