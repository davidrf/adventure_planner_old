class AddPasswordToAdventure < ActiveRecord::Migration
  def change
    add_column :adventures, :password, :string
  end
end
