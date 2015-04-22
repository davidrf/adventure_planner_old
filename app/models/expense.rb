class Expense < ActiveRecord::Base
  belongs_to :adventure
  belongs_to :adventure_membership
  belongs_to :adventure_host

  validates :name, presence: true
  validates :cost_in_cents, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  }
  validates :adventure, presence: true

  def owner
    membership_record = adventure_host || adventure_membership
    membership_record.user
  end

  def bought_by?(user)
    supplier = nil
    if adventure_host
      supplier = adventure_host.user
    elsif adventure_membership
      supplier = adventure_membership.user
    end
    supplier == user
  end

  def self.convert_cost_in_cents_to_float(input)
    valid_cost_in_cents = Float(input[:cost_in_cents]) rescue false
    if valid_cost_in_cents
      input[:cost_in_cents] = (valid_cost_in_cents * 100).to_i
    end
    input
  end

  def cost
    '%.2f' % (cost_in_cents / 100.0)
  end
end
