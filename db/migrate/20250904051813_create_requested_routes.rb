class CreateRequestedRoutes < ActiveRecord::Migration[8.0]
  def change
    create_table :requested_routes do |t|
      t.references :subject, polymorphic: true, null: false
      t.string :start_point_name, comment: "出発地名"
      t.geometry :start_point_location, null: false, comment: "出発地点"
      t.string :end_point_name, comment: "目的地名"
      t.geometry :end_point_location, null: false, comment: "目的地点"
      t.string :purpose, comment: "通学,部活,習い事など"
      t.text :comment
      t.boolean :is_existing_service_available, null: false

      t.timestamps
    end
  end
end
