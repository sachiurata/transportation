class AddNotNullToAdminUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :admin_users, :email, false
    change_column_null :admin_users, :password_digest, false
    change_column_null :admin_users, :role, false, 0
  end
end
