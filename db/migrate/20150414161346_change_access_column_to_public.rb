class ChangeAccessColumnToPublic < ActiveRecord::Migration
  def up
    remove_column :adventures, :access
    add_column :adventures, :public, :boolean, null: false, default: true
  end

  def down
    remove_column :adventures, :public
    add_column :adventures, :access, :string
  end
end
