class EventsController < ApplicationController

  # before_action :authenticate_user, only: %i[index show update destroy]
  # before_action :authenticate_admin, only: %i[index show update destroy]

  def index
    @events = Event.all
    render template: "events/index"
  end

  def show
    @event = Event.find(params[:id])
    render template: "events/show"
  end

  def create
    user = User.find(params[:user_id])
    if user.statuses.length > 0
      calendar_color = 'danger'
    else
      if user.note
        calendar_color = 'warning'
      else
        calendar_color = 'primary'
      end
    end
    # create Event
    @event = Event.new(
      date: params[:date],
      start: params[:start],
      end: params[:end],
      user_id: params[:user_id],
      duration_total: params[:duration_total],
      status: "booked",
      price: params[:price],
      calendar_color: calendar_color,
      tax: params[:tax]
    )
    if @event.save
      config = Config.find(1)
      interval = Event.new(
        date: params[:date],
        start: params[:end],
        end: Time.zone.parse(params[:end]) + config.interval.minutes,
        user_id: 2, # user id 2 => interval. See the seed file
        duration_total: config.interval,
        status: "booked",
        price: 0,
        calendar_color: 'gray',
        tax: 0
      )
      if interval.save
        # update BusinessTime
        business_times = BusinessTime.where(date: params[:date], time: params[:start]...(Time.zone.parse(params[:end]) + config.interval.minutes))
        business_times.each do |business_time|
          business_time.available = false
          business_time.save
        end
      end
      # create EventMenu
      menu_ids = params[:menus]
      event_id = @event.id
      menu_ids.each do |menu_id|
        event_menu = EventMenu.new(
          event_id: event_id,
          menu_id: menu_id,
          user_id: params[:user_id],
          status: "booked",
        )
        event_menu.save
      end
      # @user = User.find(params[:user_id])
      # EventMailer.with(user: @user, event: event_id).event_confirm.deliver_now
      render template: "events/show"
    else
      business_times.each do |business_time|
        business_time.available = true
        business_time.save
      end
      render json: {errors: @event.errors.full_message}
    end
  end

  def update
    config = Config.find(1)
    user = User.find(params[:user_id])
    if user.statuses.length > 0
      calendar_color = 'danger'
    else
      if user.note
        calendar_color = 'warning'
      else
        calendar_color = 'primary'
      end
    end
    # open previous event time slots
    @event = Event.find(params[:id])
    prev_business_times = BusinessTime.where(date: @event.date, time: @event.start...(@event.end + config.interval.minutes))
    prev_business_times.each do |business_time|
      business_time.available = true
      business_time.save
      if !business_time.save
        render json: {errors: business_time.errors.full_message}
      end
    end
    # update interval
    config = Config.find(1)
    p prev_interval = Event.find_by(date: @event.date, start: @event.end)
    current_interval = prev_interval
    current_interval.date = params[:date]
    current_interval.start = params[:end]
    current_interval.end = Time.zone.parse(params[:end]) + config.interval.minutes
    current_interval.user_id = 2 # user id 2 => interval. See the seed file
    current_interval.duration_total = config.interval
    current_interval.status = 'booked'
    current_interval.price = 0
    current_interval.tax = 0
    current_interval.calendar_color = 'gray'
    if current_interval.save
      p current_interval
      @event.date = params[:date] || @event.date
      @event.start = params[:start] || @event.start
      @event.end = params[:end] || @event.end
      @event.user_id = params[:user_id] || @event.user_id
      @event.duration_total = params[:duration_total] || @event.duration_total
      @event.status = params[:status] || @event.status
      @event.price = params[:price] || @event.price
      @event.tax = params[:tax] || @event.tax
      @event.calendar_color = calendar_color || @event.calendar_color
      if @event.save
        # close current time slots
        current_business_times = BusinessTime.where(date: params[:date], time: params[:start]...(Time.zone.parse(params[:end]) + config.interval.minutes))
        current_business_times.each do |business_time|
          business_time.available = false
          if business_time.save
          else
            render json: {errors: business_time.errors.full_message}
          end
        end
        event_menus = EventMenu.where(event_id: @event.id)
        menu_ids = params[:menus]
        i = 0
        event_menus.each do |menu|
          menu.menu_id = menu_ids[i]
          if menu.save
          else
            render json: {errors: event_menu.errors.full_message}
          end
          i += 1
        end
        render template: "events/show"
      else
        # put back interval
        prev_interval.save
        p prev_interval
        # put back time slots
        prev_business_times.each do |business_time|
          business_time.available = true
          if business_time.save
          else
            render json: {errors: business_time.errors.full_message}
          end
        end
        render json: {errors: @event.errors.full_message}
      end
    else
      render json: {errors: current_interval.errors.full_message}
    end

  end

  def destroy
    config = Config.find(1)
    @event = Event.find(params[:id])
    business_times = BusinessTime.where(date: @event.date, time: @event.start...(@event.end + config.interval.minutes))
    business_times.each do |business_time|
      business_time.available = true

      if business_time.save
      else
        render json: {errors: business_time.errors.full_message}
      end
    end
    event_menus = @event.event_menus
    event_menus.each do |em|
      em.status = "canceled"
      if em.save
      else
        render json: {errors: em.errors.full_message}
      end
    end
    @event.status = "canceled"
    if @event.save
    else
      render json: {errors: @event.errors.full_message}
    end
    p interval = Event.find(params[:id].to_i + 1)
    interval.status = "canceled"
    p interval
    if interval.save
      p true
      render template: "events/show"
    else
      render json: {errors: @event.errors.full_message}
    end
  end

  def monthlyReport

    def getMonthlyEventsTotal(events)
      monthly_count = []
      month = 1
      while month <= 12
        monthly_count << events.filter{|event| event.date.strftime('%m') == format('%02d', month) && event.status == 'booked' && event.user.id != 2}.length
        month += 1
      end
      return monthly_count
    end

    def getMonthlyMenusTotal(events)
      menus = events.filter{|event| event.status == 'booked' && event.user.id != 2}.map{|event| event.menus}.flatten
      grouped = menus.group_by{|key, value| key.title}
      grouped.each do |key, value|
        grouped[key] = value.length
      end
      return grouped
    end

    def getMonthlySalesTotal(events)
      monthly_total = []
      month = 1
      booked = events.filter{|event| event.status == 'booked' && event.user.id != 2}
      while month <= 12
        monthly = booked.filter{|event| event.date.strftime('%m') == format('%02d', month)}.map{|event| event.price}.sum
        monthly_total << monthly
        month += 1
      end
      return monthly_total
    end

    year = params[:year].to_i

    # current year
    current_events = Event.where(date: "#{year}-01-01".."#{year}-12-31")
    current_monthly_events = getMonthlyEventsTotal(current_events)
    current_menus = getMonthlyMenusTotal(current_events)
    current_monthly_sales = getMonthlySalesTotal(current_events)

    current_monthly_menu_price = current_events.filter{|event| event.status == 'booked'}.map{|event| event.menus }.flatten.group_by{|event| event.title }
    current_total_price_by_menu = {}
    current_monthly_menu_price.each do |key, value|
      current_total_price_by_menu[key] = value.map{|v| v.price}.sum
    end

    # prev year
    prev_events = Event.where(date: "#{year - 1}-01-01".."#{year - 1}-12-31")
    prev_year_events = getMonthlyEventsTotal(prev_events)
    prev_sales_monthly = getMonthlySalesTotal(prev_events)

    result = {
      events: {
        "currentMonthlyEvents": current_monthly_events,
        "prevYearEvents": prev_year_events,
        "currentMonthlyEventsSum": current_monthly_events.sum,
        "prevYearEventsSum": prev_year_events.sum
      },
      menus: {
        "currentMenus": current_menus,
        "currentTotalPriceByMenu": current_total_price_by_menu
      },
      sales: {
        "currentMonthlySales": current_monthly_sales,
        "prevSalesMonthly": prev_sales_monthly,
        "currentMonthlySalesSum": current_monthly_sales.sum.to_formatted_s(:delimited),
        "prevSalesMonthlySum": prev_sales_monthly.sum.to_formatted_s(:delimited)
      }
    }
    render json: result.as_json
  end

end