# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
  admin.role = :general
end

# 開発環境でのみ実行するテストデータを記述します。
if Rails.env.development?
  puts 'Start seeding for development environment...'

  # find_or_create_by! を使うことで、`bin/rails db:seed`を何度実行しても
  # 同じユーザーが重複して作成されることを防ぎます。
  user = User.find_or_create_by!(email: 'test@example.com') do |u|
    u.password = 'password'
    u.password_confirmation = 'password'
  end

  # 緯度経度情報を作成するためのジオメトリファクトリ
  # RGeo gemがgeometry型のデータを扱うために必要です。
  # スキーマ定義(db/schema.rb)ではSRIDが0(型のみ指定)となっていますが、
  # 一般的なGPSデータ(WGS 84)を扱う場合はSRID: 4326を指定します。
  factory = RGeo::Geographic.spherical_factory(srid: 4326)

  # テスト用の経路情報を作成
  # ユーザーと出発地名でユニークなレコードを検索または作成します。
  requested_route = RequestedRoute.find_or_create_by!(user: user, start_point_name: '佐沼高校') do |route|
    route.start_point_location = factory.point(141.20436169239665, 38.69134368373125) # (経度, 緯度) の順に変更
    route.end_point_name = '自宅'
    route.end_point_location = factory.point(141.36511885576596, 38.7566679680149) # (経度, 緯度) の順に変更
    route.purpose = '通学'
    route.comment = '最寄りのバス停まで5㎞あり、山道なので送迎が必要です。'
    route.is_existing_service_available = false
  end

  # 上記で作成した経路情報に紐づく希望時間を作成
  # 経路、曜日、時間でユニークなレコードを検索または作成します。
  RequestedTime.find_or_create_by!(
    requested_route: requested_route,
    requested_day: '月曜日',
    requested_time: '16:30'
  )

  RequestedTime.find_or_create_by!(
    requested_route: requested_route,
    requested_day: '金曜日',
    requested_time: '17:30'
  )

  puts 'Seeding for development environment is complete.'
end
