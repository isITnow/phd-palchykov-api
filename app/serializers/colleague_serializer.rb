class ColleagueSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :position, :phone, :email, :photo_url, :created_at

  def photo_url
    return unless object.photo.attached?

    url_for(object.photo)
  end
end
