class CreateChildren < ActiveRecord::Migration[8.0]
  def change
    create_table :children do |t|
      t.references :user, null: false, foreign_key: true
      t.string :postcode
      t.string :school_name
      t.integer :grade, null: false
      t.integer :school_type, null: false, default: 0, comment: "enum: elementary, secondary, high"

      t.timestamps
    end
  end
end
