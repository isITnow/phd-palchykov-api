class PhotoAlbumSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers  

  attributes :id, :title, :cover_image_url, :pictures_list, :created_at

  def cover_image_url
    if object.cover_image.attached?
      url_for(object.cover_image)
    end
  end
  
  def pictures_list
    if object.pictures
      object.pictures.map do |picture|
        {
          id: picture.id,
          filename: picture.filename,
          url: url_for(picture),
          metadata: picture.metadata
        }
      end
    end
  end
  
end