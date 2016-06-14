class ChangeColumnToAdminUsers < ActiveRecord::Migration
  def change
  	remove_column :admin_users , :role ,:string
  end
end
