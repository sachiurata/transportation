class CreateRequestedTimes < ActiveRecord::Migration[8.0]
  def change
    create_table :requested_times do |t|
      t.references :requested_route, null: false, foreign_key: true
      t.string :requested_day, null: false, comment: "曜日"
      t.time :requested_time, null: false, comment: "希望時間帯"
      t.string :departure_or_arrival, null: false, comment: "出発 or 到着"

      t.timestamps
    end
  end
end
