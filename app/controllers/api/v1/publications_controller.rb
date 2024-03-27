# frozen_string_literal: true

class Api::V1::PublicationsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_publication_period!
  before_action :set_publication!, only: %i[update destroy]

  include ErrorHandling

  def index
    @publications = @publication_period.publications.order(sequence_number: :desc)

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

  def update # rubocop:disable Metrics/AbcSize
    old_cover_blob = @publication.cover.blob if @publication.cover.attached? && publication_params[:cover]
    old_abstract_blob = @publication.abstract.blob if @publication.abstract.attached? && publication_params[:abstract]

    if @publication.update publication_params
      render json: @publication, status: :accepted
    else
      render json: { error: @publication.errors.full_messages.to_sentence }, status: :unprocessable_entity
      reattach_cover_and_abstract old_cover_blob, old_abstract_blob
    end
  end

  def destroy
    @publication.destroy

    head :no_content
  end

  private

  def publication_params
    params.require(:publication).permit(:title, :year, :sequence_number, :source, :source_url, :cover, :abstract,
                                        authors: [])
  end

  def set_publication_period!
    @publication_period = PublicationPeriod.find params[:publication_period_id]
  end

  def set_publication!
    @publication = @publication_period.publications.find params[:id]
  end

  def reattach_cover_and_abstract(old_cover_blob, old_abstract_blob)
    reattach_image @publication, :cover, old_cover_blob if old_cover_blob.present?
    reattach_image @publication, :abstract, old_abstract_blob if old_abstract_blob.present?
  end
end
