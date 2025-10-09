class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.text :text, null: false, comment: "質問文"
      t.integer :question_type, null: false, comment: "enum: multiple_choice, free_text, multiple_choice_and_free_text"
      t.integer :display_order, null: false, comment: "表示順"

      t.timestamps
    end
  end
end
