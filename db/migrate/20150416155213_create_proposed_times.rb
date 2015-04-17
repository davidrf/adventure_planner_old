class CreateProposedTimes < ActiveRecord::Migration
  def change
    create_table :proposed_times do |t|
      t.date :date, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.integer :adventure_id, null: false
    end
    add_column :adventures, :poll_opened_at, :timestamp
  end
end
