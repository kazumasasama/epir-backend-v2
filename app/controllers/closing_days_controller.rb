class ClosingDaysController < ApplicationController

  def index
    @closing_days = ClosingDay.all
    render template: "closings/index"
  end

  def create
    time_slots = BusinessTime.where(date: params[:date])
    availability = time_slots.map{|slot| slot.available}
    if availability.all?(true) 
      config = Config.find(1)
      if config.start % 1 != 0
        start_time = "#{config.start.floor}:30"
      elsif config.start % 1 == 0
        start_time = "#{config.start.floor}:00"
      end
      if config.end % 1 != 0
        end_time = "#{config.end.floor}:30"
      elsif config.end % 1 == 0
        end_time = "#{config.end.floor}:00"
      end
      date = params[:date]
      start_date = "#{date} #{start_time}"
      end_date = "#{date} #{end_time}"
      @closing_day = ClosingDay.new(
        date: date,
        start: start_date,
        end: end_date,
        calendar_color: "closing",
        title: "定休日",
        content: "<font-awesome-icon icon='fa-solid fa-ban' />"
      )
      if @closing_day.save
        time_slots = BusinessTime.where(date: @closing_day.date)
        time_slots.each do |slot|
          slot.available = false
          if slot.save
          else
            render json: {error: slot.errors.full_message}
          end
        end
        render template: "closings/show"
      else
        render json: {error: @closing_day.errors.full_message}
      end
    else
      render json: {error: "既に予約が入っています。予約をキャンセルしてから再度実行してください。"}.as_json
    end

  end

  def update
    @closing_day = ClosingDay.find(params[:id])
    date = params[:date]
    prev_date = @closing_day.date
    # 新しい日付のタイムスロット
    time_slots = BusinessTime.where(date: date)
    availability = time_slots.map{|slot| slot.available}
    if availability.all?(true)
      config = Config.find(1)
      if config.start % 1 != 0
        start_time = "#{config.start.floor}:30"
      elsif config.start % 1 == 0
        start_time = "#{config.start.floor}:00"
      end
      if config.end % 1 != 0
        end_time = "#{config.end.floor}:30"
      elsif config.end % 1 == 0
        end_time = "#{config.end.floor}:00"
      end
      start_date = "#{date} #{start_time}"
      end_date = "#{date} #{end_time}"

      @closing_day.date = date || @closing_day.date
      @closing_day.start = start_date || @closing_day.start
      @closing_day.end = end_date || @closing_day.end
      if @closing_day.save
        time_slots = BusinessTime.where(date: @closing_day.date)
        time_slots.each do |slot|
          slot.available = false
          if slot.save
          else
            render json: {error: slot.errors.full_message}
          end
        end
        prev_time_slots = BusinessTime.where(date: prev_date)
        prev_time_slots.each do |slot|
          slot.available = true
          if slot.save
          else
            render json: {error: slot.errors.full_message}
          end
        end
        render template: "closings/show"
      else
        render json: {error: @closing_day.errors.full_message}
      end
    else
      render json: {error: "既に予約が入っています。予約をキャンセルしてから再度実行してください。"}.as_json
    end
  end

  def destroy
    @closing_day = ClosingDay.find(params[:id])
    if @closing_day.delete
      render json: @closing_day
    else
      render json: {error: @closing_day.errors.full_message}
    end
  end

end
