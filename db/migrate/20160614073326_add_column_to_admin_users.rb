class AddColumnToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :role, :string ,default: "admin_user"
  end
end
