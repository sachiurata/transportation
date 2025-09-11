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

  # ユーザー1の作成
  user1 = User.find_or_create_by!(email: 'test1@example.com') do |u|
    u.password = 'password'
    u.password_confirmation = 'password'
  end

  # ユーザー2の作成
  user2 = User.find_or_create_by!(email: 'test2@example.com') do |u|
    u.password = 'password'
    u.password_confirmation = 'password'
  end

  # 緯度経度情報を作成するためのジオメトリファクトリ
  factory = RGeo::Geographic.spherical_factory(srid: 4326)

  # --- ユーザー1のデータ ---
  requested_route1 = RequestedRoute.find_or_create_by!(user: user1, start_point_name: '佐沼高校') do |route|
    route.start_point_location = factory.point(141.20436169239665, 38.69134368373125)
    route.end_point_name = '自宅'
    route.end_point_location = factory.point(141.36511885576596, 38.7566679680149)
    route.purpose = '通学'
    route.comment = '最寄りのバス停まで5㎞あり、山道なので送迎が必要です。'
    route.is_existing_service_available = false
  end

  RequestedTime.find_or_create_by!(
    requested_route: requested_route1,
    requested_day: '月曜日',
    requested_time: '16:30'
  )

  RequestedTime.find_or_create_by!(
    requested_route: requested_route1,
    requested_day: '金曜日',
    requested_time: '17:30'
  )

  # --- ユーザー2のデータ ---
  requested_route2 = RequestedRoute.find_or_create_by!(user: user2, start_point_name: '佐沼高校') do |route|
    route.start_point_location = factory.point(141.20436169239665, 38.69134368373125)
    route.end_point_name = '自宅'
    route.end_point_location = factory.point(141.2500, 38.7000)
    route.purpose = '通勤'
    route.comment = '夏休みの部活の時はバスで帰れません。'
    route.is_existing_service_available = false
  end

  RequestedTime.find_or_create_by!(
    requested_route: requested_route2,
    requested_day: '火曜日',
    requested_time: '18:00'
  )

  RequestedTime.find_or_create_by!(
    requested_route: requested_route2,
    requested_day: '木曜日',
    requested_time: '19:00'
  )

  puts 'Seeding for development environment is complete.'
end
