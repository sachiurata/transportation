class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :user_name, null: false
      t.string :password_digest, null: false
      t.string :postcode
      t.integer :num_of_children, null: false

      t.timestamps
    end
  end
end
