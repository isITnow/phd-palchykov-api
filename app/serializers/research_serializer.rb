# frozen_string_literal: true

class ResearchSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :payload, :illustrations

  has_many :illustrations

  delegate :illustrations, to: :object
end
