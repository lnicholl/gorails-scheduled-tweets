class PasswordMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.reset.subject
  #
  def reset
  # render out email in HTML text in password mailer reset.html.erb
    @token = params[:user].signed_id(purpose: "password reset", expires_in: 15.minutes)

    #grab user from passwords_reset_controller with call, call reser, render view 
    mail to: params[:user].email
  end
end
