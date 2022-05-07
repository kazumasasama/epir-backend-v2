class UsersController < ApplicationController
  
  before_action :authenticate_user, only: %i[update destroy]
  # before_action :authenticate_admin, only: %i[index]

  def index
    users = User.all
    render json: users.as_json
  end

  def show
    user = User.find(params[:id])
    render json: user.as_json
  end

  def create
    address = "#{params[:address]}, #{params[:city]}, #{params[:state]}"
    # p address
    results = Geocoder.search(address).first.coordinates
    latitude = results[0].to_f
    longitude = results[1].to_f

    user = User.new(
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
      lat: latitude,
      lon: longitude
    )
    if user.save
      render json: user.as_json
    else
      render json: {errors: user.errors.full_message}
    end
  end

  def update
    address = "#{params[:address]}, #{params[:city]}, #{params[:state]}"
    # p address
    results = Geocoder.search(address).first.coordinates
    latitude = results[0].to_f
    longitude = results[1].to_f

    user = User.find(params[:id])
    user.first_name = params[:first_name] || user.first_name
    user.last_name = params[:last_name] || user.last_name
    user.password = params[:password] || user.password
    password_confirmation = params[:password_confirmation]
    user.email = params[:email] || user.email
    user.phone = params[:phone] || user.phone
    user.gender = params[:gender] || user.gender
    user.zip = params[:zip] || user.zip
    user.state = params[:state] || user.state
    user.city = params[:city] || user.city
    user.address = params[:address] || user.address
    user.note = params[:note] || user.note
    user.birthday = params[:birthday] || user.birthday
    user.status = params[:status] || user.status
    user.lat = latitude || user.lat
    user.lon = longitude || user.lon
    if user.save
      render json: user.as_json
    else
      render json: {errors: user.errors.full_message}
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

end
