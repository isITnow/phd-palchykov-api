module AttachedImageValidation
  extend ActiveSupport::Concern

  included do
    private

    def validate_attached_image attachment, required_size
      if attachment.present?
        unless attachment.content_type.in?(%w(image/png image/jpg image/jpeg image/gif image/webp))
          errors.add(attachment.name, 'must be a PNG, JPG, JPEG, WEBP or GIF')
        end
        if attachment.blob.byte_size > required_size.megabytes
          errors.add(attachment.name, "is too big. Please select a file smaller than #{required_size}MB")
        end
      end
    end
  end
end
