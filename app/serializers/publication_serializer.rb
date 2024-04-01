# frozen_string_literal: true

class PublicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  include AttachmentData
  attributes :id, :publication_period_id, :year, :sequence_number, :title, :source, :source_url, :authors, :cover_data,
             :abstract_data, :created_at

  def cover_data
    return unless object.cover.attached?

    attachment_data object, :cover
  end

  def abstract_data
    return unless object.abstract.attached?

    attachment_data object, :abstract
  end
end
