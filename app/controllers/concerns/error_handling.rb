# frozen_string_literal: true

module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :notfound
    rescue_from JWT::ExpiredSignature, with: :token_expired
  end

  private

  def notfound
    render json: { message: 'Record not found' }, status: :not_found
  end

  def token_expired
    render json: { message: 'Signature has expired' }, status: :unauthorized
  end
end
