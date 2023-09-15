class Api::V1::ResearchesController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!, only: %i[create destroy]
  before_action :set_research!, only: :destroy

  include Api::V1::ErrorHandling

  def index
    @researches = Api::V1::Research.includes(:illustrations).order(created_at: :desc)
    render json: @researches, status: :ok
  end

  def create
    @research = Api::V1::Research.new research_params

    if @research.save
      render json: @research, status: :created
    else
      render json: { error: @research.errors.full_messages.to_sentence }, status: :unprocessable_entity
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

  def set_research!
    @research = Api::V1::Research.find params[:id]
  end
end
