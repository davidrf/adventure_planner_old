class ProposedTime < ActiveRecord::Base
  belongs_to :adventure

  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :adventure, presence: true
end
