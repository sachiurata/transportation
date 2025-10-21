require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without user_name" do
    # user_nameなしでユーザーを新規作成しようとする
    # パスワードは有効なものを設定する
    user = User.new(password: "password", password_confirmation: "password")
    assert_not user.save, "Saved the user without a user_name"
  end

  test "user_name should be unique" do
    # 既存のユーザーと同じuser_nameで新規作成しようとする
    existing_user = users(:one) # fixturesから既存ユーザーを取得
    user = User.new(user_name: existing_user.user_name, password: "password", password_confirmation: "password")
    assert_not user.save, "Saved the user with a duplicate user_name"
  end
end
