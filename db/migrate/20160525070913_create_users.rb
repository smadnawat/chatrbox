class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, default: ""
      t.string :username, default: ""
      t.string :full_name, default: ""
      t.string :fb_location, default: ""
      t.string :image, default: ""
      t.string :profile_status, default: ""
      t.boolean :is_active, default: true
      t.string :fb_id, default: ""
      t.string :authentication_token, default: ""
      t.boolean :is_subscribed, default: false

      t.timestamps null: false
    end
  end
end
