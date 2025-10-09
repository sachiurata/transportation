class UsersController < ApplicationController
  def new
    @user = User.new
    @user.build_user_profile
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to controller: :users, action: :show, id: @user.id
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(
      :user_name, :password, :password_confirmation,
      user_profile_attributes: [ :postcode, :num_of_objects ]
    )
  end
end
