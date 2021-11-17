class ProfileController < ApplicationController
  before_action :set_user

  def edit_profile

  end

  def update_profile
    # data = params.require(:user).permit(:name, :dob, :mobile)
    if @user.update(
      :name => params[:user][:name],
      :dob => params[:user][:dob],
      :mobile => params[:user][:mobile],
    )
      redirect_to home_path, notice: 'Profile has been updated!'
    else
      render :edit_profile
    end
  end


  def set_user
    @user = User.find(session[:user_id])
  end
end
