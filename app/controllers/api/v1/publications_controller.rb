class Api::V1::PublicationsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!, only: %i[create update destroy]
  before_action :set_publication_period!
  before_action :set_publication!, only: %i[update destroy]

  include Api::V1::ErrorHandling

  def index
    @publications = @publication_period.publications.order(year: :desc)

    render json: @publications, status: :ok
  end

  def create
    @publication = @publication_period.publications.build publication_params

    if @publication.save
      render json: @publication, status: :created
    else
      render json: { error: @publication.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    if @publication.update publication_params
      render json: @publication, status: :accepted
    else
      render json: { error: @publication.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy
    @publication.destroy

    head :no_content
  end
  
  private

  def publication_params
    params.require(:publication).permit(:title, :year, :sequence_number, :source, :source_url, :cover, :abstract, authors: [])
  end

  def set_publication_period!
    @publication_period = Api::V1::PublicationPeriod.find params[:publication_period_id]
  end
  
  def set_publication!
    @publication = @publication_period.publications.find params[:id]
  end
end
