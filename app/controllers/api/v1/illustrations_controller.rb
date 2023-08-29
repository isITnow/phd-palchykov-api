class Api::V1::IllustrationsController < ApplicationController
  before_action :set_research

  def create
    @illustration = @research.illustrations.build illustration_params

    unless @illustration.save
      render json: @illustration.errors, status: :unprocessable_entity
    end
  end

  private

  def illustration_params
    params.require(:illustration).permit(:description, :image)
  end

  def set_research
    @research = Reserch.find params[:id]
  end
  
end
