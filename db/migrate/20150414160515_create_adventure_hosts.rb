class CreateAdventureHosts < ActiveRecord::Migration
  def change
    create_table :adventure_hosts do |t|
      t.integer :user_id, null: false
      t.integer :adventure_id, null: false
      t.index :user_id
      t.index :adventure_id
      t.index [:user_id, :adventure_id], unique: true
    end
  end
end
