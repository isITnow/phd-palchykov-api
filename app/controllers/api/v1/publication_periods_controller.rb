class Api::V1::PublicationPeriodsController < ApplicationController
  before_action :set_publication_period!, only: %i[show]
  def index
    @publication_periods = PublicationPeriod.all

    render json: @publication_periods, status: 200
  end

  def show
    @publications = @publication_period.publications

    render json: @publications, status: 200
  end

  private

  def set_publication_period!
    @publication_period = PublicationPeriod.find params[:id]
  end
  
end
