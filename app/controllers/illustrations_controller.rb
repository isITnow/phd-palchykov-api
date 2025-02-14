# frozen_string_literal: true

class IllustrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_research!
  before_action :set_illustration!, except: %i[create]

  include ErrorHandling

  def show
    render json: @illustration, status: :ok
  end

  def create
    illustration = @research.illustrations.build illustration_params

    if illustration.save
      render json: illustration, status: :created
    else
      render json: { message: illustration.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    update_item_with_image_attached @illustration, :schema, illustration_params
  end

  def destroy
    @illustration.destroy

    head :no_content
  end

  private

  def illustration_params
    # TODO: fix ERROR: `Unpermitted parameter: :research_id`
    params.permit(:description, :schema, :sequence_number)
  end

  def set_research!
    @research = Research.find params[:research_id]
  end

  def set_illustration!
    @illustration = @research.illustrations.find params[:id]
  end
end
