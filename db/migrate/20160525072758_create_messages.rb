class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :user, index: true, foreign_key: true
      t.references :chatroom, index: true, foreign_key: true
      t.text :content, default: ""
      t.string :media, default: ""
      t.text :is_read, array: true, default: []
      t.text :is_delete, array: true, default: []

      t.timestamps null: false
    end
  end
end
