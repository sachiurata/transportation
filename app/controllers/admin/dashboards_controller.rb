class Admin::DashboardsController < Admin::BaseController
  def top
  end

  def heatmap
    # @latitude = 38.78200655266919
    # @longitude = 141.3628399833645

    routes = RequestedRoute.all

    # 各ルートの出発地の緯度・経度を抽出し、JSON形式に変換
    # rgeoの機能により、latitudeを.y  longitudeを.x で値を取得する
    @routes_data = routes.map do |route|
      {
        start_lat: route.start_point_location.y,
        start_lng: route.start_point_location.x,
        end_lat: route.end_point_location.y,
        end_lng: route.end_point_location.x
      }
    end.to_json.html_safe
  end
end
