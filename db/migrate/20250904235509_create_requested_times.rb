class CreateRequestedTimes < ActiveRecord::Migration[8.0]
  def change
    create_table :requested_times do |t|
      t.references :requested_route, null: false, foreign_key: true
      t.string :requested_day, null: false
      t.time :requested_time, null: false

      t.timestamps
    end
  end
end
