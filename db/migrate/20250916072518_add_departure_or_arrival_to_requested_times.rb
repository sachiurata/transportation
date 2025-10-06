class AddDepartureOrArrivalToRequestedTimes < ActiveRecord::Migration[8.0]
  def change
    add_column :requested_times, :departure_or_arrival, :string
  end
end
