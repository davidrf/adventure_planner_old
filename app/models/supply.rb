class Supply < ActiveRecord::Base
  belongs_to :adventure
  belongs_to :adventure_membership

  validates :name, presence: true
  validates :adventure, presence: true
end
