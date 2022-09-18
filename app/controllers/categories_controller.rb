class CategoriesController < ApplicationController

  def show
    category = Category.find(params[:id])
    render json: category.as_json
  end

  def index
    categories = Category.all
    active_categories = categories.select{|category| category.active == true}
    render json: active_categories.as_json
  end

  def create
    category = Category.new(
      title: params[:title],
    )
    if category.save
      render json: category.as_json
    else
      render json: {error: category.errors.full_message}
    end
  end

  def update
    category = Category.find(params[:id])
    category.title = params[:title] || category.title
    category.active = params[:active]
    if category.save
      render json: category.as_json
    else
      render json: {error: category.errors.full_message}
    end
  end

end
