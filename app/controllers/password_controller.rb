class PasswordController < ApplicationController

  def random_password
    "12345"
    #(0...8).map{65.+(rand(25)).chr}.join
  end

  def forget_password
		if request.post?
			user = User.find_by_email(params[:email])
      if user
        new_password = random_password
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
    @user = User.new
    if request.post?
      #somehow this validation is not working
      @user = User.find(session[:user_id])
      user_params = params.require(:user).permit(:password, :password_confirmation)
      if @user.update(user_params)
        redirect_to home_path, notice: 'password has been updated'
      else
        render :reset_password
      end
    end
  end


end
