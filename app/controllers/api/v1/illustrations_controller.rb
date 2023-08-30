class Api::V1::IllustrationsController < ApplicationController
  before_action :set_research

  def create
    @illustration = @research.illustrations.build illustration_params

    
    if @illustration.save
      render json: @illustration, status: :created
    else
      render json: @illustration.errors, status: :unprocessable_entity
    end
  end

  private

  def illustration_params
    params.require(:illustration).permit(:description, :schema)
  end

  def set_research
    @research = Research.find params[:research_id]
  end
  
end
