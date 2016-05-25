class CreateBackgrouds < ActiveRecord::Migration
  def change
    create_table :backgrouds do |t|
      t.string :name, default: ""
      t.string :image, default: ""

      t.timestamps null: false
    end
  end
end
