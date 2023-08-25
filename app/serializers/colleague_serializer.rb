class ColleagueSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :phone, :email, :photo_url, :created_at

  def photo_url
    if object.photo.attached?
      rails_blob_url(object.photo, only_path: true)
    end
  end
end
