# frozen_string_literal: true

class CollaboratorSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include AttachmentData
  attributes :id, :name, :position, :category, :link, :created_at, :photo_data

  def photo_data
    return unless object.photo.attached?

    attachment_data object, :photo # Using the method from AttachmentData concern
  end
end
