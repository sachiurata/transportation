class CreateAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :answers do |t|
      t.references :subject, polymorphic: true, null: false, comment: "'Child'など"
      t.references :question, null: false, foreign_key: true
      t.text :free_text, comment: "自由回答"

      t.timestamps
    end
  end
end
