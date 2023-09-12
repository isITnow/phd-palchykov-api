class Api::V1::IllustrationsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!, only: %i[create update destroy]
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
