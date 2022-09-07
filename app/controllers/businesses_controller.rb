class BusinessesController < ApplicationController
  
  def show
    business = Business.find(params[:id])
    render json: business.as_json
  end

  def create
    business = Business.new(
      name: params[:name],
      email: params[:email],
      phone: params[:phone],
      state: params[:state],
      city: params[:city],
      address: params[:address],
      zip: params[:zip],
      url: params[:url],
      insta: params[:insta],
      twitter: params[:twitter],
      facebook: params[:facebook]
    )
    if business.save
      render json: business.as_json
    else
      render json: {errors: business.errors.full_message}
    end
  end

  def update
    business = Business.find(params[:id])
    business.name = params[:name]
    business.email = params[:email]
    business.phone = params[:phone]
    business.state = params[:state]
    business.city = params[:city]
    business.address = params[:address]
    business.zip = params[:zip]
    business.url = params[:url]
    business.insta = params[:insta]
    business.twitter = params[:twitter]
    business.facebook = params[:facebook]
    if business.save
      render json: business.as_json
    else
      render json: {errors: business.errors.full_message}
    end
  end

end
