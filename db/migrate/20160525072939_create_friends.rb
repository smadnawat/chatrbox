class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.references :user, index: true, foreign_key: true
      t.references :background, index: true, foreign_key: true
      t.boolean :is_notified, default: true
      t.integer :member_id
      t.boolean :is_paid, default: false
      t.boolean :is_block, default: false
      t.boolean :is_added, default: false

      t.timestamps null: false
    end
  end
end
