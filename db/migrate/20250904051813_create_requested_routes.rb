class CreateRequestedRoutes < ActiveRecord::Migration[8.0]
  def change
    create_table :requested_routes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :start_point_name
      t.geometry :start_point_location, null: false
      t.string :end_point_name
      t.geometry :end_point_location, null: false
      t.string :purpose
      t.text :comment
      t.boolean :is_existing_service_available, null: false

      t.timestamps
    end
  end
end
