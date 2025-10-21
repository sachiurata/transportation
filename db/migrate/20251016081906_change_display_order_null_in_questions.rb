class ChangeDisplayOrderNullInQuestions < ActiveRecord::Migration[8.0]
  def change
    change_column_null :questions, :display_order, true
  end
end
