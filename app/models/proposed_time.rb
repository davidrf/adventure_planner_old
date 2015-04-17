class ProposedTime < ActiveRecord::Base
  belongs_to :adventure
  has_many :votes, class_name: "ProposedTimeVote"

  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :adventure, presence: true

  def vote_record(user)
    membership_record = AdventureMembership.find_by(user: user, adventure: adventure)
    votes.find_by(adventure_membership: membership_record)
  end
end
