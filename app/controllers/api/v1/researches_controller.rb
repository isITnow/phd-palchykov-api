# frozen_string_literal: true

class Api::V1::ResearchesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_research!, except: %i[index create]

  include ErrorHandling

  def index
    researches = Research.includes(:illustrations).order(created_at: :desc)

    render json: researches, status: :ok
  end

  def show
    render json: @research, status: :ok
  end

  def create
    research = Research.new research_params

    if research.save
      render json: research, status: :created
    else
      render json: { message: research.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    if @research.update research_params
      render json: @research, status: :accepted
    else
      render json: { message: @research.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy
    @research.destroy

    head :no_content
  end

  private

  def research_params
    params.permit(:payload)
  end

  def set_research!
    @research = Research.find params[:id]
  end
end
