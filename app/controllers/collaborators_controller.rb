# frozen_string_literal: true

class CollaboratorsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_collaborator!, except: %i[index create]

  include ErrorHandling

  def index
    collaborators = Collaborator.order(id: :asc)

    render json: collaborators, status: :ok
  end

  def show
    render json: @collaborator, status: :ok
  end

  def create
    collaborator = Collaborator.new collaborator_params

    if collaborator.save
      render json: collaborator, status: :created
    else
      render json: { message: collaborator.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    update_item_with_image_attached @collaborator, :photo, collaborator_params
  end

  def destroy
    @collaborator.destroy

    head :no_content
  end

  private

  def collaborator_params
    params.permit(:category, :link, :name, :position, :photo)
  end

  def set_collaborator!
    @collaborator = Collaborator.find params[:id]
  end
end
