class CommentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :post_id, :author, :body, :created_at, :comment_image

  def comment_image
    return unless object.comment_image.attached?

    {
      image_url: url_for(object.comment_image),
      metadata: {
        width: object.comment_image.metadata[:width],
        height: object.comment_image.metadata[:height]
      }
    }
  end
end
