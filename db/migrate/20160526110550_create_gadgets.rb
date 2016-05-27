class CreateGadgets < ActiveRecord::Migration
  def change
    create_table :gadgets do |t|
      t.string :gadget_id, default: ""
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
