class PasswordResetsController < ApplicationController

  before_action :get_user,          only: %i[update]
  before_action :valid_user,        only: %i[update]
  before_action :check_expiration,  only: %i[update]

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      render json: {message: "メールアドレスにパスワード再設定のためのリンクを送信しました。"}
    else
      render json: {error: "メールアドレスは登録されていません"}, status: 404
    end
  end

  def update
    if params[:password] === params[:password_confirmation]
      @user.password = params[:password]
      if @user.save
        render json: {message: "パスワードが更新されました。"}
      else
        render json: {error: @user.errors.full_message}
      end
    else
      render json: {error: "パスワードとパスワード確認が一致していません。"}
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end
    # 正しいユーザーかどうか確認する
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        render json: {error: "アカウントが有効ではありません。"}
      end
    end
    # トークンが期限切れかどうか確認する
    def check_expiration
      if @user.password_reset_expired?
        render json: {error: "リンクの有効期限が切れています。"}
      end
    end
end
