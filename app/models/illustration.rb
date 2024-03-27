# frozen_string_literal: true

class Illustration < ApplicationRecord
  include AttachedImageValidation
  include Validatable

  belongs_to :research

  has_one_attached :schema

  validates :description, :schema, presence: true
  validates :schema, presence: { message: 'must be attached' }, on: :create

  validate do
    validate_attached_image schema, 1
  end
end
