# frozen_string_literal: true

class ResearchSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :source_list, :title, :illustrations

  has_many :illustrations

  delegate :illustrations, to: :object

  def source_list
    parsed_payload['sourceList'] || []
  end

  def title
    parsed_payload['title']
  end

  private

  def parsed_payload
    JSON.parse(object.payload) || {}
  end
end
