# frozen_string_literal: true

class Colleague < ApplicationRecord
  include AttachedImageValidation

  has_one_attached :photo

  validates :email, uniqueness: { allow_nil: true }, allow_nil: true
  validates :name, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :photo, presence: { message: 'must be attached' }, on: :create
  validates :position, presence: true, length: { minimum: 5 }

  validate do
    validate_attached_image photo, 1
  end
end
