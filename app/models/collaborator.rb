# frozen_string_literal: true

class Collaborator < ApplicationRecord
  include AttachedImageValidation

  has_one_attached :photo

  enum category: { local: 0, international: 1, alumni: 2 }, _default: :local

  validates :name, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :photo, presence: { message: 'must be attached' }, on: :create
  validates :position, presence: true, length: { minimum: 5 }
  validates :link, length: { minimum: 5 }, uniqueness: true, allow_nil: true

  validate do
    validate_attached_image photo, 1
  end
end
