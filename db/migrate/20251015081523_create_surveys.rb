class CreateSurveys < ActiveRecord::Migration[8.0]
  def change
    create_table :surveys do |t|
      t.references :admin_user, null: false, foreign_key: true
      t.string :survey_name, null: false
      t.timestamps
    end
  end
end
