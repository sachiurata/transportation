require "test_helper"

class Admin::QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # テスト用の管理者ユーザーを取得し、ログインする
    @admin_user = admin_users(:one)
    post admin_session_url, params: { session: { user_name: @admin_user.user_name, password: "password" } }
    assert_response :redirect

    # このテストで質問を追加・表示する対象のアンケートを取得
    @survey = surveys(:one)
  end

  test "should get index" do
    get admin_survey_questions_url(@survey)
    assert_response :success
  end

  test "should get new" do
    get new_admin_survey_question_url(@survey)
    assert_response :success
  end

  test "should create question" do
    # Question.countが1増えることを確認
    assert_difference("Question.count") do
      # createアクションにはPOSTリクエストを送る
      post admin_survey_questions_url(@survey), params: {
        question: {
          text: "新しい質問",
          question_type: "free_text" # 整数 1 を文字列 "free_text" に修正
        }
      }
    end

    # 作成後は、続けて質問を追加できるよう、新規作成ページにリダイレクトされることを確認
    assert_redirected_to new_admin_survey_question_url(@survey)
  end
end
