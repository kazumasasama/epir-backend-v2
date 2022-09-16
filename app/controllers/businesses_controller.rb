class BusinessesController < ApplicationController

  before_action :authenticate_admin, only: %i[show create update]
  
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
    business.name = params[:name] || business.name
    business.email = params[:email] || business.email
    business.phone = params[:phone] || business.phone
    business.state = params[:state] || business.state
    business.city = params[:city] || business.city
    business.address = params[:address] || business.address
    business.zip = params[:zip] || business.zip
    business.url = params[:url] || business.url
    business.insta = params[:insta] || business.insta
    business.twitter = params[:twitter] || business.twitter
    business.facebook = params[:facebook] || business.facebook
    if business.save
      render json: business.as_json
    else
      render json: {errors: business.errors.full_message}
    end
  end

end
