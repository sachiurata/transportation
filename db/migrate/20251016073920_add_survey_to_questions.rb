class AddSurveyToQuestions < ActiveRecord::Migration[8.0]
  def change
    add_reference :questions, :survey, null: false, foreign_key: true
  end
end
