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
        UserResetPasswordMailer.with(user: user, password: new_password).reset_password.deliver_later
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
      #somehow this validation is not working
      #letting the validation to run for specific case
      user_params = params.require(:user).permit(:password, :password_confirmation)
      if @user.valid?(:password_setup) && @user.update(user_params)
        redirect_to home_path, notice: 'password has been updated'
      else
        render :reset_password
      end
    end
  end


end
