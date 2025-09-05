# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_09_04_235509) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "postgis"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
  end

  create_table "requested_routes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "start_point_name"
    t.geometry "start_point_location", limit: {srid: 0, type: "geometry"}, null: false
    t.string "end_point_name"
    t.geometry "end_point_location", limit: {srid: 0, type: "geometry"}, null: false
    t.string "purpose"
    t.text "comment"
    t.boolean "is_existing_service_available", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_requested_routes_on_user_id"
  end

  create_table "requested_times", force: :cascade do |t|
    t.bigint "requested_route_id", null: false
    t.string "requested_day", null: false
    t.time "requested_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["requested_route_id"], name: "index_requested_times_on_requested_route_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "requested_routes", "users"
  add_foreign_key "requested_times", "requested_routes"
end
