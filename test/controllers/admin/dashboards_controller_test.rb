require "test_helper"

class Admin::DashboardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # 1. フィクスチャから管理者ユーザーを取得
    @admin_user = admin_users(:one)
    # 2. ログイン処理をシミュレートする
    post admin_session_path, params: { session: { user_name: @admin_user.user_name, password: "password" } }
  end

  test "should get top" do
    get admin_root_path
    assert_response :success
  end

  test "should get heatmap" do
    # ルーティング定義に合わせてパスを修正
    get admin_dashboards_heatmap_path
    assert_response :success
  end

  test "should redirect if not logged in" do
    # 念のため、ログアウトした場合にリダイレクトされるかもテストする
    delete admin_session_path
    get admin_root_path
    assert_redirected_to admin_login_path
  end
end
