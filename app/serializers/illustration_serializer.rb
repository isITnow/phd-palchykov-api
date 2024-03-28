# frozen_string_literal: true

class IllustrationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include AttachmentData
  attributes :id, :sequence_number, :description, :schema_data, :created_at

  belongs_to :research

  def schema_url
    return unless object.schema.attached?

    url_for(object.schema)
  end

  def schema_data
    return unless object.schema.attached?

    attachment_data object, :schema # Using the method from AttachmentData concern
  end
end
