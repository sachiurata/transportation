require "test_helper"

class RequestedTimeTest < ActiveSupport::TestCase
  setup do
    @requested_route = requested_routes(:one)
    @requested_time = RequestedTime.new(
      requested_route: @requested_route,
      requested_day: "月",
      requested_time: "08:30:00"
    )
  end

  test "should be valid" do
    assert @requested_time.valid?
  end

  test "should belong to a requested route" do
    @requested_time.requested_route = nil
    assert_not @requested_time.valid?
  end

  test "requested_day should be present" do
    @requested_time.requested_day = nil
    assert_not @requested_time.valid?
  end

  test "requested_time should be present" do
    @requested_time.requested_time = nil
    assert_not @requested_time.valid?
  end
end
