require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  setup do
    @survey = surveys(:one)
    @question = Question.new(
      text: "新しい質問です",
      question_type: 1,
      survey: @survey
    )
  end

  test "should be valid with all attributes" do
    assert @question.valid?
  end

  test "should be invalid without text" do
    @question.text = nil
    assert_not @question.valid?
    assert_not_empty @question.errors[:text], "can't be blank"
  end

  test "should be invalid without question_type" do
    @question.question_type = nil
    assert_not @question.valid?
    assert_not_empty @question.errors[:question_type], "can't be blank"
  end

  test "should be invalid without a survey" do
    @question.survey = nil
    assert_not @question.valid?
    assert_not_empty @question.errors[:survey], "must exist"
  end

  test "should be valid without display_order" do
    @question.display_order = nil
    assert @question.valid?
  end

  test "should destroy associated question_options when destroyed" do
    question_with_options = questions(:one)
    # 最初に選択肢が存在することを確認
    assert_not_empty question_with_options.question_options

    # 質問を削除
    assert_difference("QuestionOption.count", -question_with_options.question_options.count) do
      question_with_options.destroy
    end
  end
end
