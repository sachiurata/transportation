class Admin::BaseController < ApplicationController
  layout "admin" # 管理者用のレイアウトファイルを指定
  before_action :require_admin_login

  private

  def require_admin_login
    unless current_admin_user
      flash[:danger] = "ログインしてください"
      redirect_to admin_login_path
    end
  end

  def current_admin_user
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id])
  end

  # ビューで current_admin_user を使えるようにする
  helper_method :current_admin_user
end
