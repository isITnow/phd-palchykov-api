# frozen_string_literal: true

class NewsSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include AttachmentData
  attributes :id, :title, :body, :links, :date, :created_at, :image_data, :image_data

  def image_data
    return unless object.image.attached?

    attachment_data object, :image # Using the method from AttachmentData concern
  end
end
