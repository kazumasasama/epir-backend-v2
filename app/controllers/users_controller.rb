class UsersController < ApplicationController

  def index
    users = User.all
    render json: users.as_json
  end

  def show
    user = User.find(params[:id])
    render json: user.as_json
  end

  def create
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
      status: params[:status]
    )
    if user.save
      render json: user.as_json
    else
      render json: {errors: user.errors.full_message}
    end
  end

  def update
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
