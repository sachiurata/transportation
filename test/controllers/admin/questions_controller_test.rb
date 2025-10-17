require "test_helper"

class Admin::QuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admin_questions_create_url
    assert_response :success
  end
end
