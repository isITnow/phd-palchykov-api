class PublicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers  
  attributes :id, :publication_period_id, :year, :sequence_number, :title, :source, :source_url, :authors, :cover_url, :abstract_url, :created_at
  
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

