class UsersController < ApplicationController
  before_action :login_required, only: [ :show ]
  before_action :correct_user,   only: [ :show ]

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
    # @userはcorrect_userで設定されるので、この行は不要になります
    # @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(
      :user_name, :password, :password_confirmation,
      user_profile_attributes: [ :postcode, :num_of_objects ]
    )
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path, alert: "権限がありません") unless @user == current_user
  end
end
