# frozen_string_literal: true

class Api::V1::AttachmentsController < ApplicationController
  before_action :authenticate_user!

  include ErrorHandling

  def purge
    @attachment = ActiveStorage::Attachment.find params[:id]
    @attachment.purge

    head :no_content
  end
end
