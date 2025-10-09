class ChangeDefaultOfSchoolTypeInChildren < ActiveRecord::Migration[8.0]
  def change
    change_column_default :children, :school_type, from: 0, to: nil
  end
end
