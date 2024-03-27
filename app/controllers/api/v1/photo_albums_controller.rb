class Api::V1::PhotoAlbumsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_photo_album!, only: %i[show update destroy]

  include ErrorHandling

  def index
    @photo_albums = PhotoAlbum.order(updated_at: :desc)

    render json: @photo_albums, action_name:, status: :ok
  end

  def show
    render json: @photo_album, action_name:, status: :ok
  end

  def create
    @photo_album = PhotoAlbum.new(photo_album_params.except(:pictures))
    pictures = params[:photo_album][:pictures]

    if pictures
      pictures.each do |picture|
        @photo_album.pictures.attach(picture)
      end
    end

    if @photo_album.save
      render json: @photo_album, status: :created
    else
      render json: { error: @photo_album.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    # Store the old cover_image blob if it exists
    if @photo_album.cover_image.attached? && photo_album_params[:cover_image]
      old_cover_image_blob = @photo_album.cover_image.blob
    end

    @photo_album.assign_attributes(photo_album_params.reject { |k| k['pictures'] })
    if @photo_album.valid?
      if photo_album_params[:pictures].present?
        photo_album_params[:pictures].each do |picture|
          @photo_album.pictures.attach(picture)
        end
      end
      if @photo_album.save
        render json: @photo_album, status: :accepted
      else
        # Use general method to render response json and reattach cover_image
        error_response_with_image_reattach @photo_album, :cover_image, old_cover_image_blob
      end
    else
      # Use general method to render response json and reattach cover_image
      error_response_with_image_reattach @photo_album, :cover_image, old_cover_image_blob
    end
  end

  def destroy
    @photo_album.destroy

    head :no_content
  end

  private

  def photo_album_params
    params.require(:photo_album).permit(:title, :cover_image, pictures: [])
  end

  def set_photo_album!
    @photo_album = PhotoAlbum.find params[:id]
  end
end
