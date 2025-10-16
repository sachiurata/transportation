class Admin::SessionsController < Admin::BaseController
  # このコントローラーではログインチェックをスキップする
  skip_before_action :require_admin_login, only: [ :new, :create ]

  def new
  end

  def create
    admin_user = AdminUser.find_by(user_name: params[:session][:user_name])
    if admin_user&.authenticate(params[:session][:password])
      session[:admin_user_id] = admin_user.id
      flash[:success] = "ログインしました。"
      redirect_to admin_root_path
    else
      flash.now[:danger] = "ユーザー名またはパスワードが正しくありません。"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:admin_user_id)
    flash[:success] = "ログアウトしました。"
    redirect_to admin_login_path, status: :see_other
  end
end
