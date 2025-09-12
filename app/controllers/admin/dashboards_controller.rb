class Admin::DashboardsController < Admin::BaseController
  def top
  end

  def heatmap
    routes = RequestedRoute.all

    # rgeoの機能により、latitudeを.y  longitudeを.x で値を取得する
    @routes_data = routes.map do |route|
      {
        start_point_name: route.start_point_name,
        start_lat: route.start_point_location.y,
        start_lng: route.start_point_location.x,
        end_lat: route.end_point_location.y,
        end_lng: route.end_point_location.x
      }
    end
  end
end
