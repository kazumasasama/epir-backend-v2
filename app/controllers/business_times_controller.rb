class BusinessTimesController < ApplicationController

  def index
    business_times = BusinessTime.where(available: true)
    render json: business_times.as_json
  end

  def show
    business_time = BusinessTime.find(params[:id])
    render json: business_time.as_json
  end

  def create
    business_time = BusinessTime.new(
      date: params[:date],
      time: params[:time],
      available: params[:available],
      event_id: params[:event_id]
    )
    if business_time.save
      render json: business_time.as_json
    else
      render json: {errors: business_time.errors.full_message}
    end
  end

  def update
    business_time = BusinessTime.find(params[:id])
    business_time.date = params[:date]
    business_time.time = params[:time]
    business_time.available = params[:available]
    business_time.event_id = params[:event_id]
    if business_time.save
      render json: business_time.as_json
    else
      render json: {errors: business_time.errors.full_message}
    end
  end

  def destroy
    business_time = BusinessTime.find(params[:id])
    if business_time.delete
      render json: business_time.as_json
    else
      render json: {errors: business_time.errors.full_message}
    end
  end

end
