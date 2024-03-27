# frozen_string_literal: true

class PublicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :publication_period_id, :year, :sequence_number, :title, :source, :source_url, :authors, :cover_url,
             :abstract_url, :created_at

  def cover_url
    return unless object.cover.attached?

    url_for(object.cover)
  end

  def abstract_url
    return unless object.abstract.attached?

    url_for(object.abstract)
  end
end
