class ApplicationController < ActionController::API
  before_action :is_valid_token?, except: %i[index]

  private

  def is_valid_token?
    render json: { message: "You are not authorized" },
            status: :unauthorized  unless devise_api_token = current_devise_api_token
  end
end
