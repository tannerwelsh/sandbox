class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.string :category

      t.timestamps
    end
  end
end
