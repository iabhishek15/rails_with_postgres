class PasswordController < ApplicationController

  def random_password
    (0...8).map{65.+(rand(25)).chr}.join
  end

  def forget_password
    if current_user
      redirect_to home_path
    end
		if request.post?
			user = User.find_by_email(params[:email])
      if user
        new_password = random_password
        UserResetPasswordMailer.with(user: user, password: new_password).reset_password.deliver_now
        if user.update(:password => new_password)
          redirect_to login_path, notice: "reset link has been send!"
        else
          flash.now[:alert] = 'something went wrong!'
          render :forget_password
        end
      else
        flash.now[:alert] = 'Email address does not exits'
        render :forget_password
      end
    end
  end

  def reset_password
    @user = current_user
    if request.post?
      user_params = params.require(:user).permit(:password, :password_confirmation)
      puts "@user.valid?(:password_setup) => #{@user.valid?(:password_setup)}"
      if @user.update(user_params) && @user.valid?(:password_setup)
        redirect_to home_path, notice: 'password has been updated'
      else
        render :reset_password
      end
    end
  end
end
