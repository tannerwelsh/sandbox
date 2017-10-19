class SetupListsAndTasks < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :tasks do |t|
      t.string :description, null: false
      t.string :status, null: false, default: "pending"

      t.references :list
      t.timestamps
    end
  end
end
