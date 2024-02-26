class Publication < ApplicationRecord
  include AttachedImageValidation
  include Validatable

  belongs_to :publication_period
  
  has_one_attached :abstract
  has_one_attached :cover
  
  validates :abstract, :cover, presence: { message: 'must be attached' }, on: :create
  validates :title, :source, :source_url, :year, presence: true

  validate do
    validate_attached_image abstract, 1
  end

  validate do
    validate_attached_image cover, 1
  end
end
