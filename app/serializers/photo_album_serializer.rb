class PhotoAlbumSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers  

  attributes :id, :title, :cover_image_url, :created_at, :pictures_list

  def cover_image_url
    if object.cover_image.attached?
      url_for(object.cover_image)
    end
  end
  
  def pictures_list
    if object.pictures && show_action?
      object.pictures.map do |picture|
        {
          id: picture.id,
          filename: picture.filename,
          picture_url: url_for(picture),
          metadata: {
            width: picture.metadata[:width],
            height: picture.metadata[:height]
          }
        }
      end
    end
  end

  def show_action?
    instance_options[:action_name] == "show"
  end
end