class ConfigsController < ApplicationController

  def show
    config = Config.find(params[:id])
    render json: config.as_json
  end

  def create
    config = Config.new(
      lang: params[:lang],
      tax: params[:tax],
      start: params[:start],
      end: params[:end],
      interval: params[:interval]
    )
    if config.save
      render json: config.as_json
    else
      render json: {error: config.errors.full_message}
    end
  end

  def update
    config = Config.find(params[:id])
    config.lang = params[:lang]
    config.tax = params[:tax]
    config.start = params[:start]
    config.end = params[:end]
    config.interval = params[:interval]
    if config.save
      render json: config.as_json
    else
      render json: {error: config.errors.full_message}
    end
  end

end
