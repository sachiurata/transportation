class CreateUserProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :postcode
      t.integer :num_of_objects, null: false, comment: "調査対象者の数"

      t.timestamps
    end
  end
end
