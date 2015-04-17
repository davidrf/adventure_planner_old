class ProposedTimeVote < ActiveRecord::Base
  belongs_to :adventure_membership
  belongs_to :proposed_time

  validates :adventure_membership, presence: true
  validates :proposed_time, presence: true
end
