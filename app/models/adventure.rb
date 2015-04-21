class Adventure < ActiveRecord::Base
  has_many :adventure_memberships, autosave: true
  has_many :members, through: :adventure_memberships, source: :user
  has_many :adventure_hosts, autosave: true
  has_many :hosts, through: :adventure_hosts, source: :user
  has_many :proposed_times
  has_many :supplies

  validates :name, presence: true
  validates :description, presence: true

  def attendees
    members + hosts
  end
end
