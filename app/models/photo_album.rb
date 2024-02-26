class PhotoAlbum < ApplicationRecord
  include AttachedImageValidation

  has_one_attached :cover_image, dependent: :destroy
  has_many_attached :pictures, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :cover_image, presence: { message: 'Cover image must be attached' }, on: :create

  validate do
    validate_attached_image(cover_image, 1)
  end

  validate do
    pictures.each do |picture|
      validate_attached_image(picture, 5)
    end
  end
end
