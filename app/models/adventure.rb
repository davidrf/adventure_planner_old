class Adventure < ActiveRecord::Base
  has_many :adventure_memberships, autosave: true
  has_many :members, through: :adventure_memberships, source: :user
  has_many :adventure_hosts, autosave: true
  has_many :hosts, through: :adventure_hosts, source: :user
  has_many :proposed_times
  has_many :supplies
  has_many :expenses

  validates :name, presence: true
  validates :description, presence: true

  def formatted_date
    date.strftime("%A %B #{date.day.ordinalize}, %Y") if date
  end

  def formatted_start_time
    start_time.strftime("%I:%M%p") if start_time
  end

  def formatted_end_time
    end_time.strftime("%I:%M%p") if end_time
  end

  def attendees
    if members.empty?
      hosts
    elsif hosts.empty?
      members
    else
      members + hosts
    end
  end

  def total_cost
    '%.2f' % (expenses.sum(:cost_in_cents) / 100.00)
  end

  def cost_per_person
    if attendees.count == 0
      0
    else
      expenses.sum(:cost_in_cents) / attendees.count
    end
  end

  def cost_per_person_formatted
    '%.2f' % (cost_per_person / 100.00)
  end

  def transactions
    if expenses.empty?
      []
    else
      money_spent_by = {}
      attendees.each do |attendee|
        money_spent_by[attendee] = 0
      end

      expenses.each do |expense|
        money_spent_by[expense.owner] += expense.cost_in_cents
      end

      people_giving_money = []
      people_receiving_money = []

      money_spent_by.each do |attendee, money_spent_by_attendee|
        money_owed = cost_per_person - money_spent_by_attendee
        person = {
          name: attendee.full_name,
          money_owed: money_owed
        }

        if money_owed > 0
          people_giving_money << person
        elsif money_owed < 0
          people_receiving_money << person
        end
      end

      people_giving_money.sort_by { |person| person[:money_owed] }.reverse!
      people_receiving_money.sort_by! { |person| person[:money_owed] }

      transaction_descriptions = []
      people_giving_money.each do |person_paying_back|
        until person_paying_back[:money_owed] == 0
          person_owed = people_receiving_money.first
          if person_paying_back[:money_owed] < person_owed[:money_owed].abs
            amount = person_paying_back[:money_owed]
          else
            amount = person_owed[:money_owed].abs
          end

          people_receiving_money[0][:money_owed] += amount
          person_paying_back[:money_owed] -= amount
          dollar_amount = '%.2f' % (amount / 100.00)
          description = "#{person_paying_back[:name]} pays #{person_owed[:name]} $#{dollar_amount}"
          transaction_descriptions << description
          people_receiving_money.sort_by! { |person| person[:money_owed] }
        end
      end
      transaction_descriptions
    end
  end
end
