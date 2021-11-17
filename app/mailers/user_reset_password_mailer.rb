class UserResetPasswordMailer < ApplicationMailer
  def reset_password
    @user = params[:user]
    @password = params[:password]
    mail(to: @user.email, subject: 'Reset Password')
  end
end
