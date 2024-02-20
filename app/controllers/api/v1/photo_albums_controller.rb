class Api::V1::PhotoAlbumsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_photo_album!, only: %i[show update destroy]

  include ErrorHandling

  def index
    @photo_albums = PhotoAlbum.order(updated_at: :desc)

    render json: @photo_albums, action_name: action_name, status: :ok
  end

  def show
    render json: @photo_album, action_name: action_name, status: :ok
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
    if photo_album_params[:cover_image]
    # Delete the old attached cover_image
      @photo_album.cover_image.purge
    end

    if @photo_album.update(photo_album_params.reject { |k| k["pictures"] })
      if photo_album_params[:pictures].present?
        photo_album_params[:pictures].each do |picture|
          @photo_album.pictures.attach(picture)
        end
      end
      render json: @photo_album, status: :accepted
    else
      render json: { error: @photo_album.errors.full_messages.to_sentence }, status: :unprocessable_entity
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