class Api::V1::ColleaguesController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!, only: %i[create update destroy]
  before_action :set_colleague!, only: %i[destroy update]

  include Api::V1::ErrorHandling
  
  def index
    @colleagues = Api::V1::Colleague.all

    render json: @colleagues, status: :ok
  end

  def create
    @colleague = Api::V1::Colleague.new colleague_params

    if @colleague.save
      render json: @colleague, status: :created
    else
      render json: { error: @colleague.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    if @colleague.update colleague_params
      render json: @colleague, status: :accepted
    else
      render json: { error: @colleague.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy
    @colleague.destroy

    head :no_content
  end
  
  
  private

  def colleague_params
    params.require(:colleague).permit(:name, :position, :email, :phone, :photo)
  end

  def set_colleague!
    @colleague = Api::V1::Colleague.find params[:id]
  end
end
