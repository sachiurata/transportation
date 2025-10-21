require "test_helper"

class Admin::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = admin_users(:one)
  end

  test "should get new" do
    get admin_login_path
    assert_response :success
  end

  test "should create session for admin user" do
    post admin_session_path, params: { session: { user_name: @admin_user.user_name, password: "password" } }
    assert_redirected_to admin_root_path
  end

  test "should not create session with invalid password" do
    # 間違ったパスワードでログインを試みる
    post admin_session_path, params: { session: { user_name: @admin_user.user_name, password: "wrong_password" } }

    # ログインページが再表示されることを確認
    assert_response :unprocessable_entity
    # エラーメッセージが表示されることを確認
    assert_not_empty flash[:danger]
    # ログインされていないことを確認
    assert_nil session[:admin_user_id]
  end

  test "should destroy session" do
    # まずログインする
    post admin_session_path, params: { session: { user_name: @admin_user.user_name, password: "password" } }
    # ログアウト処理を実行
    delete admin_session_path
    assert_redirected_to admin_login_path
  end
end
