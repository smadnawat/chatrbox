class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name, default: ""
      t.string :flag_image, default: ""

      t.timestamps null: false
    end
  end
end
