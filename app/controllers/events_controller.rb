class EventsController < ApplicationController

  def index
    events = Event.all
    render json: events.as_json
  end

  def show
    event = Event.find(params[:id])
    render json: event.as_json
  end

  def create
    # create Event
    event = Event.new(
      date: params[:date],
      start: params[:start],
      end: params[:end],
      user_id: params[:user_id],
      duration_total: params[:duration_total],
    )
    if event.save
      # update BusinessTime
      business_times = BusinessTime.where(date: params[:date], time: params[:start]...params[:end])
      business_times.each do |business_time|
        business_time.available = false
        business_time.save
        if !business_time.save
          render json: {errors: business_time.errors.full_message}
        end
      end
      # create EventMenu
      menu_ids = params[:menus]
      menu_ids.each do |menu_id|
        event_menu = EventMenu.new(
          event_id: Event.last.id,
          menu_id: menu_id,
          user_id: params[:user_id],
          status: "booked",
        )
        event_menu.save
        if !event_menu.save
          render json: {errors: event_menu.errors.full_message}
        end
      end
      render json: event.as_json
    else
      business_times.each do |business_time|
        business_time.delete
      end
      render json: {errors: event.errors.full_message}
    end
  end

  def update
    event = Event.find(params[:id])
    business_times = BusinessTime.where(date: event.date, time: event.start...event.end)
    business_times.each do |business_time|
      business_time.available = true
      business_time.save
      if !business_time.save
        render json: {errors: business_time.errors.full_message}
      end
    end
    event.date = params[:date]
    event.start = params[:start]
    event.end = params[:end]
    event.user_id = params[:user_id]
    event.duration_total = params[:duration_total]
    if event.save
      business_times = BusinessTime.where(date: params[:date], time: params[:start]...params[:end])
      business_times.each do |business_time|
        business_time.available = false
        business_time.save
        if !business_time.save
          render json: {errors: business_time.errors.full_message}
        end
      end
      menus = EventMenu.where(event_id: event.id, status: "booked")
      menus.each do |menu|
        menu.status = "canceled"
        menu.save
        if !menu.save
          render json: {errors: menu.errors.full_message}
        end
      end
      menu_ids = params[:menus]
      menu_ids.each do |menu_id|
        event_menu = EventMenu.new(
          event_id: event.id,
          menu_id: menu_id,
          user_id: params[:user_id],
          status: "booked"
        )
        event_menu.save
        if !event_menu.save
          render json: {errors: event_menu.errors.full_message}
        end
      end

      render json: event.as_json
    else
      render json: {errors: event.errors.full_message}
    end
  end

  def destroy
    event = Event.find(params[:id])
    business_times = BusinessTime.where(date: event.date, time: event.start...event.end)
    business_times.each do |business_time|
      business_time.available = true
      business_time.save
      if !business_time.save
        render json: {errors: business_time.errors.full_message}
      end
    end
    event_menus = event.event_menus
    event_menus.each do |em|
      em.status = "canceled"
      em.save
      if !em.save
        render json: {errors: em.errors.full_message}
      end
    end
    if event.delete
      render json: {message: "Event Deleted"}
    else
      render json: {errors: event.errors.full_message}
    end
  end

end