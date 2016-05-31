class CreateUsersLocationJoinTable < ActiveRecord::Migration
  def up
  	create_table :users_locations, id: false do |t|
  		t.column :user_id, :integer
  		t.column :location_id, :integer
  	end
  end
  def down
  	drop_table :users_locations
  end
end
