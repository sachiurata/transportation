require "test_helper"

class Admin::SurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    # テスト用の管理者ユーザーを取得し、ログインする
    @admin_user = admin_users(:one)
    post admin_session_url, params: { session: { user_name: @admin_user.user_name, password: "password" } }
    assert_response :redirect # ログイン後のリダイレクトを確認
  end

  test "should get index" do
    get admin_surveys_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_survey_url
    assert_response :success
  end

  test "should create survey" do
    # Survey.countが1増えることを確認
    assert_difference("Survey.count") do
      # createアクションにはPOSTリクエストを送る
      post admin_surveys_url, params: { survey: { survey_name: "新しいアンケート", admin_user_id: @admin_user.id } }
    end

    # 作成後は、作成されたアンケートの詳細ページにリダイレクトされることを確認
    assert_redirected_to admin_survey_url(Survey.last)
  end

  test "should show survey" do
    # テスト用のアンケートデータを取得
    @survey = surveys(:one)
    get admin_survey_url(@survey) # 正しいヘルパー名と引数を指定
    assert_response :success
  end
end
