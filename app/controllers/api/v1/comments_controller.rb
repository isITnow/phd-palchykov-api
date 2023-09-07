class Api::V1::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!, only: %i[create destroy]
  before_action :set_post
  before_action :set_comment, only: %i[destroy]

  def create
    @comment = @post.comments.build comment_params

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { error: @comment.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy

    head :no_content
  end
  
  private

  def comment_params
    params.require(:comment).permit(:author, :body)
  end

  def set_post
    @post = Post.find params[:post_id]
  end

  def set_comment
    @comment = @post.comments.find params[:id]
  end
  

end