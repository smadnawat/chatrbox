class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :plan, default: ""
      t.references :user, index: true, foreign_key: true
      t.boolean :is_paid, default: false

      t.timestamps null: false
    end
  end
end
