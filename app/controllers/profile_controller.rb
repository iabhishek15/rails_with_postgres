class ProfileController < ApplicationController
  before_action :set_user

  def edit_profile

  end

  def update_profile
    user_params = params.require(:user).permit(:name, :dob, :mobile, :profile_image)
    if @user.update(user_params)
      redirect_to home_path, notice: 'Profile has been updated!'
    else
      render :edit_profile
    end
  end


  def set_user
    @user = User.find(session[:user_id])
  end
end
