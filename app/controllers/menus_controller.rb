class MenusController < ApplicationController

  before_action :authenticate_admin, only: %i[create update destroy]

  def index
    @menus = Menu.all
    render template: "menus/index"
  end

  def show
    @menu = Menu.find(params[:id])
    render template: "menus/show"
  end

  def create
    menu = Menu.new(
      title: params[:title],
      duration: params[:duration],
      price: params[:price],
      description: params[:description]
    )
    if menu.save
      render json: menu.as_json
    else
      render json: {errors: menu.errors.full_message}
    end
  end

  def update
    menu = Menu.find(params[:id])
    menu.title = params[:title] || menu.title
    menu.duration = params[:duration] || menu.duration
    menu.price = params[:price] || menu.price
    menu.description = params[:description] || menu.description
    menu.active = params[:active]
    if menu.save
      render json: menu.as_json
    else
      render json: {errors: menu.errors.full_message}
    end
  end

  def destroy
    menu = Menu.find(params[:id])
    if menu.delete
      render json: menu.as_json
    else
      render json: {errors: menu.errors.full_message}
    end
  end
end
