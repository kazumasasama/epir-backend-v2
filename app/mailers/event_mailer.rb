class EventMailer < ApplicationMailer
  
  def event_confirm
    @user = params[:user]
    @event = Event.find(params[:event])
    mail(to: @user.email, subject: 'Your appointment confirmation (test message)')
  end

end
