# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  include ErrorHandling

  private

  def respond_with(current_user, _opts = {})
    render json: {
      status: { code: 200, message: 'Logged in successfully.' },
      data: UserSerializer.new(current_user)
    }, status: :ok
  end

  def respond_to_on_destroy
    current_user = find_current_user_from_token

    if current_user
      render_logged_out_successfully
    else
      render_session_not_found
    end
  end

  def find_current_user_from_token
    return if request.headers['Authorization'].blank?

    jwt_payload = JWT.decode(request.headers['Authorization'].split.last,
                             Rails.application.credentials.devise_jwt_secret_key!).first
    User.find_by(id: jwt_payload['sub'])
  end

  def render_logged_out_successfully
    render json: {
      status: 200,
      message: 'Logged out successfully'
    }, status: :ok
  end

  def render_session_not_found
    render json: {
      status: 401,
      message: "Couldn't find an active session."
    }, status: :unauthorized
  end
end
