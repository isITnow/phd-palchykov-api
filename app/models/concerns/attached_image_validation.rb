# frozen_string_literal: true

module AttachedImageValidation
  extend ActiveSupport::Concern

  included do
    private

    def validate_attached_image(attachment, required_size)
      return if attachment.blank?

      unless attachment.content_type.in?(%w[image/png image/jpg image/jpeg image/gif image/webp])
        errors.add(attachment.name, 'must be a PNG, JPG, JPEG, WEBP or GIF')
      end
      return unless attachment.blob.byte_size > required_size.megabytes

      errors.add(attachment.name, "is too big. Please select a file smaller than #{required_size}MB")
    end
  end
end
