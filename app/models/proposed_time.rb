class ProposedTime < ActiveRecord::Base
  belongs_to :adventure
  has_many :votes, class_name: "ProposedTimeVote"

  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :adventure, presence: true

  def formatted_date
    date.strftime("%A %B #{date.day.ordinalize}, %Y")
  end

  def formatted_start_time
    start_time.strftime("%I:%M%p")
  end

  def formatted_end_time
    end_time.strftime("%I:%M%p")
  end

  def vote_record(user)
    membership_record = AdventureMembership.find_by(
      user: user,
      adventure: adventure
    )
    votes.find_by(adventure_membership: membership_record)
  end
end
