class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.string :name, null: false
      t.integer :month
      t.integer :day

      t.timestamps
    end
  end
end
