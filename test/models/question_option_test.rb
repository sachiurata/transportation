require "test_helper"

class QuestionOptionTest < ActiveSupport::TestCase
  setup do
    @question = questions(:one)
    @question_option = QuestionOption.new(question: @question, text: "Option 1")
  end

  test "should be valid" do
    assert @question_option.valid?
  end

  test "text should be present" do
    @question_option.text = ""
    assert_not @question_option.valid?
    # エラーメッセージの文字列ではなく、:text属性にエラーがあることを確認
    assert_not_empty @question_option.errors[:text]
  end

  test "should belong to a question" do
    @question_option.question = nil
    assert_not @question_option.valid?
    # :question属性にエラーがあることを確認
    assert_not_empty @question_option.errors[:question]
  end

  test "should destroy associated answers when destroyed" do
    # fixturesから、回答が紐付いている選択肢を取得
    option_with_answer = question_options(:q1_option_two)

    # 前提として、回答が存在することを確認
    assert_not_empty option_with_answer.answers

    # 選択肢を削除し、関連する回答も削除されることを確認
    assert_difference("AnswerOption.count", -1) do
      option_with_answer.destroy
    end
  end
end
