# frozen_string_literal: true

class ColleagueSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include AttachmentData
  attributes :id, :name, :position, :phone, :email, :created_at, :photo_data

  def photo_data
    return unless object.photo.attached?

    attachment_data object, :photo # Using the method from AttachmentData concern
  end
end
