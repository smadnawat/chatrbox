class CreateSingleChatMessages < ActiveRecord::Migration
  def change
    create_table :single_chat_messages do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :member_id
      t.text :message, default: ""
      t.string :media, default: ""
      t.boolean :is_read, default: false
      t.boolean :is_delete, default: false

      t.timestamps null: false
    end
  end
end
