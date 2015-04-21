class Supply < ActiveRecord::Base
  belongs_to :adventure
  belongs_to :adventure_membership
  belongs_to :adventure_host

  validates :name, presence: true
  validates :adventure, presence: true

  def brought_by?(user)
    supplier = nil
    if adventure_host
      supplier = adventure_host.user
    elsif adventure_membership
      supplier = adventure_membership.user
    end
    supplier == user
  end

  def unclaimed?
    !(adventure_host || adventure_membership)
  end
end
