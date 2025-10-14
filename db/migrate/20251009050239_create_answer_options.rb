class CreateAnswerOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :answer_options do |t|
      t.references :answer, null: false, foreign_key: true
      t.references :question_option, null: false, foreign_key: true

      t.timestamps
    end
  end
end
