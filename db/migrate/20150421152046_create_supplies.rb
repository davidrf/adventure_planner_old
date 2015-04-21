class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.string :name, null: false
      t.integer :adventure_id, null: false
      t.integer :adventure_membership_id
    end
  end
end
