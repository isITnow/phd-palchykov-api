class Api::V1::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false  
  before_action :authenticate_devise_api_token!, only: %i[create update destroy]
  before_action :set_post!, except: %i[index create]

  include Api::V1::ErrorHandling

  def index
    @posts = Post.order(updated_at: :desc)

    render json: @posts, status: :ok
  end

  def show
    render json: @post, action_name: action_name, status: :ok
  end
  
  def create
    @post = User.first.posts.build post_params

    if @post.save
      render json: @post, status: :created
    else
      render json: { error: @post.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update post_params
      render json: @post, action_name: action_name, status: :accepted
    else
      render json: { error: @post.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    head :no_content
  end
  
  private

  def post_params
    params.require(:post).permit(:body)
  end

  def set_post!
    @post = Post.find params[:id]
  end
end
