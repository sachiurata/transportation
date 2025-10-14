class SessionsController < ApplicationController
  def new
    # ログインフォームを表示
  end

  def create
    user = User.find_by(user_name: params[:session][:user_name])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "ログインしました。"
    else
      flash.now[:alert] = "ニックネームまたはパスワードが正しくありません。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "ログアウトしました。"
  end
end
