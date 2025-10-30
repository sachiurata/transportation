require "test_helper"

class SurveyTest < ActiveSupport::TestCase
  setup do
    @admin_user = admin_users(:one)
    @survey = Survey.new(
      survey_name: "新しいアンケート",
      admin_user: @admin_user
    )
  end

  test "should be valid" do
    assert @survey.valid?
  end

  test "survey_name should be present" do
    @survey.survey_name = ""
    assert_not @survey.valid?
    assert_not_empty @survey.errors[:survey_name], "can't be blank"
  end

  test "should belong to an admin user" do
    @survey.admin_user = nil
    assert_not @survey.valid?
    assert_not_empty @survey.errors[:admin_user], "must exist"
  end

  test "should destroy associated questions when destroyed" do
    survey_with_questions = surveys(:one)
    # 最初に質問が存在することを確認
    assert_not_empty survey_with_questions.questions

    # アンケートを削除し、関連する質問も削除されることを確認
    assert_difference("Question.count", -survey_with_questions.questions.count) do
      survey_with_questions.destroy
    end
  end

  # test "should destroy associated answers when destroyed" do
  #   survey_with_answers = surveys(:one)
  #   # 最初に回答が存在することを確認
  #   assert_not_empty survey_with_answers.answers

  #   # アンケートを削除し、関連する回答も削除されることを確認
  #   assert_difference("Answer.count", -survey_with_answers.answers.count) do
  #     survey_with_answers.destroy
  #   end
  # end

  # requested_routesについても追加が必要
end
