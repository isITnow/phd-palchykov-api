# frozen_string_literal: true

class AddUniqueIndexToPhotoAlbumTitle < ActiveRecord::Migration[7.0]
  def change
    add_index :photo_albums, :title, unique: true
  end
end
