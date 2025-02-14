# frozen_string_literal: true

class Api::V1::PublicationPeriodsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_publication_period!, only: %i[destroy]

  include ErrorHandling

  def index
    publication_periods = PublicationPeriod.all

    render json: publication_periods, status: :ok
  end

  def create
    publication_period = PublicationPeriod.new publication_period_params

    if publication_period.save
      render json: publication_period, status: :created
    else
      render json: { message: publication_period.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy
    @publication_period.destroy

    head :no_content
  end

  private

  def publication_period_params
    params.permit(:title)
  end

  def set_publication_period!
    @publication_period = PublicationPeriod.find params[:id]
  end
end
