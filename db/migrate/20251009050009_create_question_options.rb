class CreateQuestionOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :question_options do |t|
      t.references :question, null: false, foreign_key: true
      t.string :text, null: false, comment: "選択肢の文言"
      t.integer :display_order, null: false, comment: "表示順"

      t.timestamps
    end
  end
end
