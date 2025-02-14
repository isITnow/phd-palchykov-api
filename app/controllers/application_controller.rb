# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username role])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username role])
  end

  private

  def update_item_with_image_attached(item, attachment, item_params)
    # Store the old photo blob if it exists
    old_image_blob = item.send(attachment).blob if item.send(attachment).attached? && item_params[attachment]

    if item.update item_params
      render json: item, status: :accepted
    else
      error_response_with_image_reattach item, attachment, old_image_blob
    end
  end

  def error_response_with_image_reattach(item, attachment, image_blob)
    render json: { message: item.errors.full_messages.to_sentence }, status: :unprocessable_entity
    # Reattach the image if it was an image update attempt
    reattach_image item, attachment, image_blob if image_blob.present?
  end

  def reattach_image(item, attachment, image_blob)
    item.send(attachment).attach image_blob
  end
end
