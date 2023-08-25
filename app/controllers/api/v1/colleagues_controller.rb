class Api::V1::ColleaguesController < ApplicationController
  before_action :set_colleague, only: %i[destroy update]

  def index
    @colleagues = Colleague.all

    render json: @colleagues, status: 200
  end

  def create
    @colleague = Colleague.new colleague_params

    if @colleague.save
      render json: @colleague, status: :created
    else
      render json: @colleague.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @colleague.update colleague_params
      render json: @colleague, status: :accepted
    else
      render json: @colleague.errors.full_messages, status: :unprocessable_entity
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

  def set_colleague
    @colleague = Colleague.find params[:id]
  end
  
end
