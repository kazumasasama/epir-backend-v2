class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      render json: {message: "メールアドレスにパスワード再設定のためのリンクを送信しました"}
    else
      render json: {error: "メールアドレスは登録されていません"}, status: 404
    end
  end

  def edit
  end
end
