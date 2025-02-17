# frozen_string_literal: true

class ColleaguesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_colleague!, except: %i[index create]

  include ErrorHandling

  def index
    colleagues = Colleague.order(id: :asc)

    render json: colleagues, status: :ok
  end

  def show
    render json: @colleague, status: :ok
  end

  def create
    colleague = Colleague.new colleague_params

    if colleague.save
      render json: colleague, status: :created
    else
      render json: { message: colleague.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    update_item_with_image_attached @colleague, :photo, colleague_params
  end

  def destroy
    @colleague.destroy

    head :no_content
  end

  private

  def colleague_params
    params.permit(:name, :position, :email, :phone, :photo)
  end

  def set_colleague!
    @colleague = Colleague.find params[:id]
  end
end
