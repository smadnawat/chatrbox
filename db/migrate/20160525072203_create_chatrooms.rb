class CreateChatrooms < ActiveRecord::Migration
  def change
    create_table :chatrooms do |t|
      t.string :name, default: ""
      t.string :image, default: ""
      t.boolean :status, default: true
      t.boolean :is_multiple, default: true
      t.references :location, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
