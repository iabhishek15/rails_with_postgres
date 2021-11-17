class AccountController < ApplicationController
  before_action :is_logged_in, only: [:signup, :create, :login]

  def signup
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?(:password_setup) && @user.save
      #here applying the mailer method
      UserWelcomeMailer.with(user: @user).welcome_user.deliver_now
      redirect_to login_path
    else
      render :signup
    end
  end

  def login
    if request.post?
      user = User.find_by_email(params[:email])
      if user && User.encrypt(params[:password]) == user.hashed_password
        session[:user_id] = user.id
        redirect_to home_path
      else
        #no error is getting showed
        flash.now[:alert] = 'Email or Password is incorrect!'
        render :login
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path
  end

  def delete
    @user = User.find(session[:user_id])
    session[:user_id] = nil
    @user.destroy
    redirect_to signup_path
  end

  def is_logged_in
    if current_user
      redirect_to home_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
