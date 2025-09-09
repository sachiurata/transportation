require "test_helper"

class Admin::DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get admin_root_path
    assert_response :success
  end

  test "should get heatmap" do
    get admin_dashboards_heatmap_path
    assert_response :success
  end
end
