class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.date :birthday
      t.string :email
      t.string :phone
      t.string :address
      t.string :city
      t.integer :zip_code
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
