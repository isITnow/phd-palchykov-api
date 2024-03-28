# frozen_string_literal: true

class PublicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include AttachmentData
  attributes :id, :publication_period_id, :year, :sequence_number, :title, :source, :source_url, :authors, :cover_data,
             :abstract_data, :created_at

  # def cover_url
  #   return unless object.cover.attached?

  #   url_for(object.cover)
  # end

  def cover_data
    return unless object.cover.attached?

    attachment_data object, :cover
  end

  def abstract_data
    return unless object.abstract.attached?

    attachment_data object, :abstract
  end

  # def abstract_url
  #   return unless object.abstract.attached?

  #   url_for(object.abstract)
  # end
end
