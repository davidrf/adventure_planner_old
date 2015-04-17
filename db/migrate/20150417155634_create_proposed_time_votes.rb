class CreateProposedTimeVotes < ActiveRecord::Migration
  def change
    create_table :proposed_time_votes do |t|
      t.integer :proposed_time_id, null: false
      t.integer :adventure_membership_id, null: false
    end
  end
end
