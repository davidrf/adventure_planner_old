class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name, null: false
      t.integer :cost_in_cents, null: false
      t.integer :adventure_id, null: false
      t.integer :adventure_membership_id
      t.integer :adventure_host_id
    end
  end
end
