class PhotoAlbum < ApplicationRecord
  has_one_attached :cover_image
  has_many_attached :pictures

  validates :title, presence: true, uniqueness: true
end
