class PhotoAlbum < ApplicationRecord
  has_one_attached :cover_image, dependent: :destroy
  has_many_attached :pictures, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :cover_image, presence: { message: 'Cover image must be attached' }, on: :create

  #!!! TODO: IMPLEMENT ATTACHMENT VALIDATION 

  # validate :validate_cover_image
  # validate :validate_pictures

  # private

  # def validate_cover_image
  #   if cover_image.attached?
  #     unless cover_image.content_type.in?(%w(image/png image/jpg image/jpeg image/webp image/gif))
  #       errors.add(:cover_image, 'must be a PNG, JPG, JPEG, GIF or WEBP')
  #     end
  #     if cover_image.blob.byte_size > 1.megabytes
  #       errors.add(:cover_image, 'is too big. Please select a file smaller than 1MB')
  #     end
  #   else
  #     errors.add(:cover_image, 'must be attached')
  #   end
  # end

  # def validate_pictures
  #   if pictures.attached?
  #     pictures.each do |picture|
  #       unless picture.content_type.in?(%w(image/png image/jpg image/jpeg image/webp image/gif))
  #         errors.add(:pictures, 'must be a PNG, JPG, JPEG, GIF or WEBP')
  #       end
  #       if picture.blob.byte_size > 5.megabytes
  #         errors.add(:pictures, 'is too big. Please select files smaller than 5MB')
  #       end
  #     end
  #   end
  # end
end
