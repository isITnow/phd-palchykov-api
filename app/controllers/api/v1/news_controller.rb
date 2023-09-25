class Api::V1::NewsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_news!, except: %i[index create]

  include ErrorHandling

  def index
    @news = News.all.order(created_at: :desc)

    render json: @news, status: :ok
  end

  def create  
    @news = News.new news_params

    if @news.save
      render json: @news, status: :created
    else
      render json: { errors: @news.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    if @news.update news_params
      render json: @news, status: :accepted
    else
      render json: { errors: @news.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy
    @news.destroy

    head :no_content
  end
  
  private

  def news_params
    params.require(:news).permit(:title, :body, :date, :image, links: [])
  end

  def set_news!
    @news = News.find params[:id]
  end
end
