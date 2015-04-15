class AdventureMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :adventure

  validates :status, inclusion: { in: %w(invited going not\ going) }
  validates :adventure, presence: true
  validates :user, presence: true
end
