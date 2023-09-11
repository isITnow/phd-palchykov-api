class ApplicationController < ActionController::API
  before_action :is_valid_token?, except: %i[index show], unless: :devise_controller?
  before_action :configure_permited_parameters, if: :devise_controller?

  private

  def is_valid_token?
    devise_api_token = current_devise_api_token
    render json: { message: "You are not authorized" },
            status: :unauthorized  unless devise_api_token
  end

  protected

  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username role])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username role])
  end
  
end
