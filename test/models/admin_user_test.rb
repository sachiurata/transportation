require "test_helper"

class AdminUserTest < ActiveSupport::TestCase
  setup do
    @admin_user = AdminUser.new(
      user_name: "new_admin",
      password: "password",
      password_confirmation: "password",
      role: :viewer
    )
  end

  test "should be valid" do
    assert @admin_user.valid?
  end

  test "user_name should be present" do
    @admin_user.user_name = "     "
    assert_not @admin_user.valid?
  end

  test "user_name should be unique" do
    # 既存のユーザー名(fixtures/admin_users.ymlの:one)をコピー
    duplicate_user = @admin_user.dup
    duplicate_user.user_name = admin_users(:one).user_name
    @admin_user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @admin_user.password = @admin_user.password_confirmation = ""
    assert_not @admin_user.valid?
  end

  test "should destroy associated surveys when destroyed" do
    admin_with_surveys = admin_users(:one)
    # 最初にアンケートが存在することを確認
    assert_not_empty admin_with_surveys.surveys

    # 管理者を削除
    assert_difference("Survey.count", -admin_with_surveys.surveys.count) do
      admin_with_surveys.destroy
    end
  end
end
