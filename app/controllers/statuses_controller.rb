class StatusesController < ApplicationController

  def index
    statuses = Status.all
    active_status = statuses.select{|status| status.status == true}.sort_by{|status| status.id }
    render json: active_status.as_json
  end

  def create
    status = Status.new(
      title: params[:title]
    )
    if status.save
      render json: status.as_json
    else
      render json: {errors: status.errors.full_message}
    end
  end

  def update
    params[:status]
    status = Status.find(params[:id])
    status.title = params[:title] || status.title
    status.status = params[:status]
    status
    if status.save
      render json: status.as_json
    else
      render json: {errors: status.errors.full_message}
    end
  end

end
