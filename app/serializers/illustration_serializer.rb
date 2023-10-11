class IllustrationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers  
  attributes :id, :sequence_number, :description, :schema_url, :created_at
  
  belongs_to :research
  
  def schema_url
    if object.schema.attached?
      url_for(object.schema)
    end
  end
end

