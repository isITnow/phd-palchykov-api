# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include AttachmentData
  attributes :id, :post_id, :author, :body, :created_at, :comment_image_data

  def comment_image_data
    return unless object.comment_image.attached?

    attachment_data object, :comment_image # Using the method from AttachmentData concern
  end
end
