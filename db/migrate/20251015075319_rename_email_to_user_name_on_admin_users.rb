class RenameEmailToUserNameOnAdminUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :admin_users, :email, :user_name
  end
end
