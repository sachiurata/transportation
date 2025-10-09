class ChildrenController < ApplicationController
  before_action :set_user
  before_action :set_child, only: [ :edit, :update ]

  def new
    @child = @user.children.build
    @child.school_type = nil
  end

  def create
    @child = @user.children.build(child_params)
    @child.postcode = @user.user_profile&.postcode
    if @child.save
      redirect_to user_path(@user), notice: "お子さんの情報を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @child.update(child_params)
      redirect_to user_path(@user), notice: "お子さんの情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_child
    @child = @user.children.find(params[:id])
  end

  def child_params
    params.require(:child).permit(:school_name, :grade, :school_type)
  end
end
