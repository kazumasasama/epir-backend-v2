class EventMenusController < ApplicationController

  def index
    ems = EventMenu.all
    render json: ems.as_json
  end

  def show
    em = EventMenu.find(params[:id])
    render json: em.as_json
  end

  def create
    em = EventMenu.new(
      event_id: params[:event_id],
      menu_id: params[:menu_id],
      user_id: params[:user_id],
      status: params[:status]
    )
    if em.save
      render json: em.as_json
    else
      render json: {errors: em.errors.full_message}
    end
  end

  def update
    em = EventMenu.find(params[:id])
    em.event_id = params[:event_id]
    em.menu_id = params[:menu_id]
    em.user_id = params[:user_id]
    em.status = params[:status]
    if em.save
      render json: em.as_json
    else
      render json: {errors: em.errors.full_message}
    end
  end

  def destroy
    em = EventMenu.find(params[:id])
    if em.delete
      render json: em.as_json
    else
      render json: {errors: em.errors.full_message}
    end
  end

end
