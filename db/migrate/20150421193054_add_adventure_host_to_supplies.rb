class AddAdventureHostToSupplies < ActiveRecord::Migration
  def change
    add_column :supplies, :adventure_host_id, :integer
  end
end
