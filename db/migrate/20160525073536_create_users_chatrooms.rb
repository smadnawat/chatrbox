class CreateUsersChatrooms < ActiveRecord::Migration
  def change
    create_table :users_chatrooms do |t|
      t.references :user, index: true, foreign_key: true
      t.references :chatroom, index: true, foreign_key: true
      t.references :backgroud, index: true, foreign_key: true
      t.boolean :is_notified, default: false

      t.timestamps null: false
    end
  end
end
