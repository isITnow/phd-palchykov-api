# frozen_string_literal: true

class NewsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_news!, except: %i[index create]

  include ErrorHandling

  def index
    all_news = News.ordered_by_date

    render json: all_news, status: :ok
  end

  def show
    render json: @news, status: :ok
  end

  def create
    news = News.new news_params

    if news.save
      render json: news, status: :created
    else
      render json: { message: news.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def update
    update_item_with_image_attached @news, :image, news_params
  end

  def destroy
    @news.destroy

    head :no_content
  end

  private

  def news_params
    params.permit(:title, :body, :date, :image, links: [])
  end

  def set_news!
    @news = News.find params[:id]
  end
end
