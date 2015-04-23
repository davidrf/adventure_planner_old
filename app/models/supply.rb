class Supply < ActiveRecord::Base
  belongs_to :adventure
  belongs_to :adventure_membership
  belongs_to :adventure_host

  validates :name, presence: true
  validates :adventure, presence: true

  def bringer
    supplier = nil
    if adventure_host
      supplier = adventure_host.user
    elsif adventure_membership
      supplier = adventure_membership.user
    end
    supplier
  end

  def brought_by?(user)
    bringer == user
  end

  def unclaimed?
    !(adventure_host || adventure_membership)
  end
end
