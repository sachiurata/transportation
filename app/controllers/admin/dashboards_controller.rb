class Admin::DashboardsController < Admin::BaseController
  def top
  end

  def heatmap
    routes = RequestedRoute.where.not(start_point_location: nil, end_point_location: nil)

    @routes_data = routes.map do |route|
      {
        id: route.id,
        start_point_name: route.start_point_name,
        end_point_name: route.end_point_name,
        start_point: {
          lat: route.start_point_location.y,
          lng: route.start_point_location.x
        },
        end_point: {
          lat: route.end_point_location.y,
          lng: route.end_point_location.x
        },
        requested_times: route.requested_times.map do |time|
          {
            day: time.requested_day,
            time: time.requested_time&.strftime("%H:%M"),
            type: time.departure_or_arrival
          }
        end
      }
    end
  end
end
