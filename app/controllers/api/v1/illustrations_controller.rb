class Api::V1::IllustrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_research!
  before_action :set_illustration!, only: %i[update destroy]

  include ErrorHandling

  def create
    @illustration = @research.illustrations.build illustration_params

    if @illustration.save
      render json: @illustration, status: :created
    else
      render json: {error: @illustration.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    if illustration_params[:schema]
      # Delete the old attached schema
      @illustration.schema.purge
    end

    if @illustration.update illustration_params
      render json: @illustration, status: :accepted
    else
      render json: { error: @illustration.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy
    @illustration.destroy

    head :no_content
  end

  private

  def illustration_params
    params.require(:illustration).permit(:description, :schema, :sequence_number)
  end

  def set_research!
    @research = Research.find params[:research_id]
  end

  def set_illustration!
    @illustration = @research.illustrations.find params[:id]
  end
end
