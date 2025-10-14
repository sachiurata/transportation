require "test_helper"

class ChildrenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # ログインしているユーザーを想定
    # 必要に応じてログイン処理をここに記述します
    # 例: post login_url, params: { user_name: @user.user_name, password: 'password' }
  end

  test "should get new" do
    get new_user_child_url(@user)
    assert_response :success
  end

  test "should create child" do
    assert_difference("Child.count") do
      post user_children_url(@user), params: { child: {
        # user_id はURLから取得されるため、通常は不要です
        grade: 1,
        school_type: "0"
        # school_name や postcode など、他の属性も必要に応じて追加
      } }
    end

    assert_redirected_to user_path(@user)
  end
end
