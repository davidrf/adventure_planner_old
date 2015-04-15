class AddEndTimeToAdventures < ActiveRecord::Migration
  def change
    add_column :adventures, :end_time, :time
  end
end
