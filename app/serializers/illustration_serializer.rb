class IllustrationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers  
  attributes :id, :description, :schema_url, :created_at
  
  belongs_to :research
  
  def schema_url
    if object.schema.attached?
      rails_blob_url(object.schema, only_path: true)
    end
  end
end

