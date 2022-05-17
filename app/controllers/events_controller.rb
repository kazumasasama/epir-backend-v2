class EventsController < ApplicationController

  before_action :authenticate_user, only: %i[index show update destroy]
  before_action :authenticate_admin, only: %i[index show update destroy]

  def index
    @events = Event.all
    render template: "events/index"
  end

  def show
    @event = Event.find(params[:id])
    render template: "events/show"
  end

  def create
    # create Event
    @new_event = Event.new(
      date: params[:date],
      start: params[:start],
      end: params[:end],
      user_id: params[:user_id],
      duration_total: params[:duration_total],
      status: "booked",
      color: params[:color]
    )
    if @new_event.save
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
      event_id = @new_event.id
      menu_ids.each do |menu_id|
        event_menu = EventMenu.new(
          event_id: event_id,
          menu_id: menu_id,
          user_id: params[:user_id],
          status: "booked",
        )
        event_menu.save
        if !event_menu.save
          render json: {errors: event_menu.errors.full_message}
        end
      end
      @user = User.find(params[:user_id])
      EventMailer.with(user: @user, event: event_id).event_confirm.deliver_now
      render json: @new_event.as_json
    else
      business_times.each do |business_time|
        business_time.available = true
        business_time.save
      end
      render json: {errors: @new_event.errors.full_message}
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
    event.date = params[:date] || event.date
    event.start = params[:start] || event.start
    event.end = params[:end] || event.end
    event.user_id = params[:user_id] || event.user_id
    event.duration_total = params[:duration_total] || event.duration_total
    event.status = params[:status] || event.status
    event.color = params[:color] || event.color
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
    event.status = "canceled"
    if event.save
      render json: event
    else
      render json: {errors: event.errors.full_message}
    end
  end

end