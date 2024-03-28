# frozen_string_literal: true

module AttachmentData
  extend ActiveSupport::Concern

  included do
    private

    def attachment_data(object, attachment)
      {
        image_id: object.send(attachment).id,
        filename: object.send(attachment).filename,
        image_url: url_for(object.image),
        metadata: {
          width: object.send(attachment).metadata[:width],
          height: object.send(attachment).metadata[:height]
        }
      }
    end
  end
end
