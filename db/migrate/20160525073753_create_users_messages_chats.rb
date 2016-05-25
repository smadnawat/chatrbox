class CreateUsersMessagesChats < ActiveRecord::Migration
  def change
    create_table :users_messages_chats do |t|
      t.references :message, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :chatroom, index: true, foreign_key: true
      t.boolean :is_read, default: false
      t.boolean :is_delete, default: false

      t.timestamps null: false
    end
  end
end
