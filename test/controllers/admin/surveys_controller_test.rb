require "test_helper"

class Admin::SurveysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_surveys_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_surveys_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_surveys_create_url
    assert_response :success
  end

  test "should get show" do
    get admin_surveys_show_url
    assert_response :success
  end
end
