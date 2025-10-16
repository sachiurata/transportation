class AddSurveyToRequestedRoutes < ActiveRecord::Migration[8.0]
  def change
    add_reference :requested_routes, :survey, null: false, foreign_key: true
  end
end
