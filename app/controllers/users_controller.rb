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
      line_id: params[:line_id],
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
      UserMailer.account_activation(@user).deliver_now
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

    if params[:password]
      if @user.authenticate(params[:current_password])
        @user.password = params[:password]
      else
        render json: {errors: "正しい現在のパスワードを入力してください"}
        return
      end
      # if @user.authenticate(params[:current_password])
      #   p "in"
      #   if params[:password] == params[:password_confirmation]
      #     @user.password = params[:password]
      #   else
      #     render json: {errors: '新しいパスワードとパスワード確認が一致していません。もう一度やり直してください'}
      #     return
      #   end
      # else
      #   render json: {errors: 'Wrong password. Try again.'}
      #   return
      # end
    else
      @user.first_name = params[:first_name] || @user.first_name
      @user.last_name = params[:last_name] || @user.last_name
      @user.email = params[:email] || @user.email
      @user.phone = params[:phone] || @user.phone
      @user.line_id = params[:line_id] || @user.line_id
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
    events = Event.where(status: 'booked')
    sales_total = events.map{|event| event.price}.sum
    users = User.where(admin: false)
    users_count = users.length - 1 #remove interval
    p sales_ave = (sales_total / users_count).to_formatted_s(:delimited)
    p sales_ave.class
    users_gender = users.group_by{|user| user.gender }
    gender_count = {}
    users_gender.each do |key, value|
      gender_count[key] = value.length
    end

    
    render json: {
      userTotal: users_count,
      genderTotal: gender_count,
      salesAve: sales_ave
    }.as_json
  end

end
