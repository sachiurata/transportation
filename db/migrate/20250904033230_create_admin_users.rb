class CreateAdminUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_users do |t|
      t.string :email
      t.string :password_digest
      t.integer :role

      t.timestamps
    end
    add_index :admin_users, :email, unique: true
  end
end
