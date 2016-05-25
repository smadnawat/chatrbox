class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
      t.references :user, index: true, foreign_key: true
      t.string :subject, default: ""
      t.text :description, default: ""

      t.timestamps null: false
    end
  end
end
