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
      description: params[:description],
      category_id: params[:category_id],
      active: params[:active]
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
    menu.category_id = params[:category_id] || menu.category_id
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

  def grouped
    menus = Menu.all
    grouped = menus.group_by{|menu| menu.category_id}
    # keys = grouped.keys
    # active_categories = Category.all.select{|category| category.active == true}
    # i = 0
    # result = {}
    # while i < active_categories.length
    #   result["#{active_categories[i].title}"] = grouped[i + 1]
    #   i += 1
    # end
    render json: grouped.as_json
  end
end
