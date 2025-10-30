require "test_helper"

class RequestedRouteTest < ActiveSupport::TestCase
  setup do
    @child = children(:child_one_for_user_one)
    @survey = surveys(:one)
    # PostGISのgeometryオブジェクトを作成するためのファクトリを使わず、
    # WKT (Well-Known Text) 形式の文字列で直接データを設定する
    @requested_route = RequestedRoute.new(
      subject: @child,
      survey: @survey,
      start_point_location: "POINT(141.1 38.6)", # 経度・緯度の例
      end_point_location: "POINT(141.2 38.7)",   # 経度・緯度の例
      is_existing_service_available: false
    )
  end

  test "should be valid" do
    assert @requested_route.valid?
  end

  test "should belong to a subject" do
    @requested_route.subject = nil
    assert_not @requested_route.valid?
  end

  test "should belong to a survey" do
    @requested_route.survey = nil
    assert_not @requested_route.valid?
  end

  test "start_point_location should be present" do
    @requested_route.start_point_location = nil
    assert_not @requested_route.valid?
  end

  test "end_point_location should be present" do
    @requested_route.end_point_location = nil
    assert_not @requested_route.valid?
  end

  test "is_existing_service_available should be present" do
    @requested_route.is_existing_service_available = nil
    assert_not @requested_route.valid?
  end

  test "should destroy associated requested_times when destroyed" do
    # フィクスチャから、requested_timeが紐付いているrequested_routeを取得
    route_with_times = requested_routes(:one)
    assert_not_empty route_with_times.requested_times

    # 経路を削除し、関連する希望時間も削除されることを確認
    assert_difference("RequestedTime.count", -route_with_times.requested_times.count) do
      route_with_times.destroy
    end
  end
end
