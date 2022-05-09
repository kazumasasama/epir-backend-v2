class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials[:GMAIL_ADDRESS]
  layout "mailer"
end
