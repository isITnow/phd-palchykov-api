class Api::V1::PublicationsController < ApplicationController
  before_action :set_publication_period
  before_action :set_publication!, only: %i[update destroy]

  def index
    @publications = @publication_period.publications

    render json: @publications, status: 200
  end

  def create
    @publication = @publication_period.publications.build publication_params

    if @publication.save
      render json: @publication, status: :created
    else
      render json: @publication.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @publication.update publication_params
      render json: @publication
    else
      render json: @publication.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @publication.destroy

    head :no_content
  end
  
  private

  def set_publication_period
    @publication_period = PublicationPeriod.find params[:publication_period_id]
  end
  
  def set_publication!
    @publication = @publication_period.publications.find params[:id]
  end
  
  def publication_params
    params.require(:publication).permit(:title, :source, :source_url, :cover_url, :abstract_url, authors: [])
  end
end
