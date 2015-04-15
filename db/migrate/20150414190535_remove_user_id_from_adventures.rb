class RemoveUserIdFromAdventures < ActiveRecord::Migration
  def up
    remove_column :adventures, :user_id
  end

  def down
    add_column :adventures, :user_id, :integer
  end
end
