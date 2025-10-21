class ChangeDisplayOrderNullInQuestionOptions < ActiveRecord::Migration[8.0]
  def change
    change_column_null :question_options, :display_order, true
  end
end
