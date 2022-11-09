class SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user.activated == false
      render json: {error: "このアカウントが有効化されていません。有効化してからログインしてください。"}
    end
    if user && user.authenticate(params[:password])
      jwt = JWT.encode(
        {
          user_id: user.id, # the data to encode
          exp: 24.hours.from_now.to_i # the expiration time
        },
        Rails.application.credentials.fetch(:secret_key_base), # the secret key
        "HS256" # the encryption algorithm
      )
      last_login = Time.zone.now
      render json: {
        jwt: jwt,
        email: user.email,
        user_id: user.id,
        admin: user.admin,
        last_login: last_login
      }, status: :created
    else
      render json: {error: "無効なログイン"}, status: :unauthorized
    end
  end
  
end
