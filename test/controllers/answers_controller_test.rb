require "test_helper"

class AnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    # テスト用のユーザーを取得
    @user = users(:one)
    # ログイン処理
    post session_url, params: { session: { user_name: @user.user_name, password: "password" } }
    assert_response :redirect

    # ログインしたユーザーに紐づくお子さんを取得
    @child = children(:child_one_for_user_one)
    # 回答対象の質問を取得
    @question1 = questions(:one) # 択一選択
    @question3 = questions(:three) # 自由記述
  end

  test "should get new" do
    # newアクションには child_id が必要
    get new_answer_url, params: { child_id: @child.id }
    assert_response :success
  end

  test "should create answers" do
    # Answerの数が1増えることを確認 (質問2つに回答するが、Answerレコードは2つ作られる)
    assert_difference("Answer.count", 2) do
      post answers_url, params: {
        child_id: @child.id,
        answers: {
          # 質問1への回答 (選択肢)
          @question1.id => {
            question_option_ids: [ question_options(:q1_option_one).id ]
          },
          # 質問3への回答 (自由記述)
          @question3.id => {
            text: "テストの自由記述回答です。"
          }
        }
      }
    end

    # 作成後はユーザー詳細ページにリダイレクトされることを確認
    assert_redirected_to user_path(@user)
    assert_equal "アンケートにご協力いただき、ありがとうございました。", flash[:notice]
  end
end
