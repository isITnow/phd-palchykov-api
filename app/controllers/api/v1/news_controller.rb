class Api::V1::NewsController < ApplicationController
  before_action :set_news, except: %i[index create]

  def index
    @news = News.all

    render json: @news, status: 200
  end

  def create
    @news = News.new news_params

    if @news.save
      render json: @news, status: :created
    else
      render json: @news.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @news.update news_params
      render json: @news, status: :accepted
    else
      render json: @news.errors.full_messages, status: :unprocessable_entity
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

  def set_news
    @news = News.find params[:id]
  end
  
end
