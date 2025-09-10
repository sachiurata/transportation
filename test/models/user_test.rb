require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    # emailなしでユーザーを新規作成しようとする
    user = User.new
    user.password = "password" # has_secure_passwordのためにパスワードは必要

    # user.saveがfalseを返す（保存に失敗する）ことを表明する
    assert_not user.save, "Saved the user without an email"
  end

  test "should not save user with duplicate email" do
    # 1人目のユーザーをフィクスチャ(test/fixtures/users.yml)から取得
    existing_user = users(:one)

    # 2人目のユーザーを、1人目と全く同じemailで作成しようとする
    user = User.new
    user.email = existing_user.email
    user.password = "password"

    # 保存に失敗することを表明する
    assert_not user.save, "Saved the user with a duplicate email"
  end
end
