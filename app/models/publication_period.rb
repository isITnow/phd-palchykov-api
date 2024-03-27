# frozen_string_literal: true

class PublicationPeriod < ApplicationRecord
  has_many :publications, dependent: :destroy

  validates :title, presence: true, uniqueness: true
end
