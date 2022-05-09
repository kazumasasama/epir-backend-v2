class UserMailer < ApplicationMailer
  # default このクラスのすべてのメッセージで使う値を1つ設定
  default from: Rails.application.credentials[:GMAIL_ADDRESS]

  def welcome_email
    @user = User.find(params[:user])
    mail(to: @user.email, subject: 'Welcome to our website (test message)')
  end

end
