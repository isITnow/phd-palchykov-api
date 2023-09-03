class Api::V1::ResearchesController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!, only: %i[:create destroy]
  before_action :set_research, only: :destroy


  def index
    @researches = Research.includes(:illustrations)
    render json: @researches, status: 200 
  end

  def create
    @research = Research.new research_params

    if @research.save
      render json: @research, status: :created
    else
      render json: @research.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @research.destroy

    head :no_content
  end
  
  private

  def research_params
    params.require(:research).permit(:payload)
  end

  def set_research
    @research = Research.find params[:id]
  end
  
  
end
