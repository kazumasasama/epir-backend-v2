class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[show update destroy]
  before_action :authenticate_admin, only: %i[index usersStatics]

  def index
    @users = User.all
    render template: "users/index"
  end

  def show
    @user = User.find(params[:id])
    render template: "users/show"
  end

  def create
    # address = "#{params[:address]}, #{params[:city]}, #{params[:state]}"
    # # p address
    # if Geocoder.search(address)
    #   results = Geocoder.search(address).first.coordinates
    #   latitude = results[0].to_f
    #   longitude = results[1].to_f
    # else
    #   latitude = nil
    #   longitude = nil
    # end

    @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      email: params[:email],
      phone: params[:phone],
      gender: params[:gender],
      zip: params[:zip],
      state: params[:state],
      city: params[:city],
      address: params[:address],
      note: params[:note],
      birthday: params[:birthday],
      status: params[:status],
      # lat: latitude,
      # lon: longitude
    )
    if @user.save
      # 保存後にUserMailerを使ってwelcomeメールを送信
      # UserMailer.with(user: @user.id).welcome_email.deliver_now
      if params[:status_ids]
        new_status = params[:status_ids]
        new_status.each do |status_id|
          us = UserStatus.new(
            user_id: params[:id],
            status_id: status_id
          )
          if !us.save
            render json: {errors: us.errors.full_message}
          end
        end
      end
      render json: @user.as_json
    else
      render json: {errors: @user.errors.full_message}
    end
  end

  def update
    @user = User.find(params[:id])
    # address = "#{params[:address]}, #{params[:city]}, #{params[:state]}"
    # if Geocoder.search(address)
    #   results = Geocoder.search(address).first.coordinates
    #   latitude = results[0].to_f
    #   longitude = results[1].to_f
    # else
    #   latitude = nil
    #   longitude = nil
    # end
    if params[:status_ids]
      current = UserStatus.where(user_id: @user.id)
      current.each do |c|
        c.delete
      end
      new_status = params[:status_ids]
      new_status.each do |status_id|
        us = UserStatus.new(
          user_id: params[:id],
          status_id: status_id
        )
        if !us.save
          render json: {errors: us.errors.full_message}
        end
      end
    end

    if params[:newPassword]
      if @user.password == params[:currentPassword]
        if params[:newPassword] == params[:passwordConfirmation]
          @user.password = params[:newPassword]
          @user.password_confirmation = params[:passwordConfirmation]
        else
          render json: {errors: 'Password does not match. Please confirm new password and try again.'}
          return
        end
      else
        render json: {errors: 'Wrong password. Try again.'}
        return
      end
    else
      @user.first_name = params[:first_name] || @user.first_name
      @user.last_name = params[:last_name] || @user.last_name
      @user.email = params[:email] || @user.email
      @user.phone = params[:phone] || @user.phone
      @user.gender = params[:gender] || @user.gender
      @user.zip = params[:zip] || @user.zip
      @user.state = params[:state] || @user.state
      @user.city = params[:city] || @user.city
      @user.address = params[:address] || @user.address
      @user.note = params[:note] || @user.note
      @user.birthday = params[:birthday] || @user.birthday
      # @user.lat = latitude || @user.lat
      # @user.lon = longitude || @user.lon
    end
    
    if @user.save
      render template: "users/show"
    else
      render json: {errors: @user.errors.full_message}
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.delete
      render json: user.as_json
    else
      render json: {errors: user.errors.full_message}
    end
  end

  def usersStatics
    def getMonthlyMenusTotal(events)
      menus = events.filter{|event| event.status == 'booked'}.map{|event| event.menus}.flatten
      grouped = menus.group_by{|key, value| key.title}
      grouped.each do |key, value|
        grouped[key] = value.length
      end
      return grouped
    end

    users = User.all
    users_count = users.length
    users_gender = users.group_by{|user| user.gender }
    gender_count = {}
    users_gender.each do |key, value|
      gender_count[key] = value.length
    end
    render json: [users_count, gender_count].as_json
  end

end
