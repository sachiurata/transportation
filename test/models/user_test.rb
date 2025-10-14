require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    # emailなしでユーザーを新規作成しようとする
    user = User.new
    user.password = "password" # has_secure_passwordのためにパスワードは必要

    # user.saveがfalseを返す（保存に失敗する）ことを表明する
    assert_not user.save, "Saved the user without an email"
  end
end
