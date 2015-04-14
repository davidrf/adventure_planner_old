class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :location
      t.date :date
      t.time :start_time
      t.string :access
      t.integer :user_id, null: false

      t.timestamps
      t.index :name
      t.index :date
      t.index :user_id
    end
  end
end
