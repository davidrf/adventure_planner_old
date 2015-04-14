class AdventureHost < ActiveRecord::Base
  belongs_to :user
  belongs_to :adventure

  validates :adventure, presence: true
  validates :user, presence: true
end
