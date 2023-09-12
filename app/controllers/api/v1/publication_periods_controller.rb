class Api::V1::PublicationPeriodsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!, only: %i[create update destroy]
  before_action :set_publication_period, only: :destroy

  def index
    @publication_periods = PublicationPeriod.all

    render json: @publication_periods, status: 200
  end

  def create
    @publication_period = PublicationPeriod.new publication_period_params

    if @publication_period.save
      render json: @publication_period, status: :created
    else
      render json: @publication_period.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @publication_period.destroy

    head :no_content
  end
  

  private

  def publication_period_params
    params.require(:publication_period).permit(:title)
  end

  def set_publication_period
    @publication_period = PublicationPeriod.find params[:id]
  end
  
end
