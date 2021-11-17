class UserWelcomeMailer < ApplicationMailer
  default from: "donotreplyonlytesting@gmail.com"

  def welcome_user
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to my website')
  end
end
