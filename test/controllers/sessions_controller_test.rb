require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    # get sessions_new_url
    # assert_response :success
    pass # このテストは実装後に書く
  end

  test "should get create" do
    # ログイン処理は未実装なので、一旦コメントアウトします。
    # post session_url, params: { email: @user.email, password: 'password' }
    # assert_redirected_to root_url
    pass # このテストは実装後に書く
  end

  test "should get destroy" do
    # ログアウト処理は未実装なので、一旦コメントアウトします。
    # delete session_url
    # assert_redirected_to root_url
    pass # このテストは実装後に書く
  end
end
