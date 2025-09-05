require "test_helper"

class RequestedRoutesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get requested_routes_index_url
    assert_response :success
  end

  test "should get new" do
    get requested_routes_new_url
    assert_response :success
  end

  test "should get create" do
    get requested_routes_create_url
    assert_response :success
  end

  test "should get show" do
    get requested_routes_show_url
    assert_response :success
  end

  test "should get edit" do
    get requested_routes_edit_url
    assert_response :success
  end

  test "should get update" do
    get requested_routes_update_url
    assert_response :success
  end
end
