require "factory_girl"

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

  factory :adventure_host do
    user
    adventure
  end

  factory :adventure_membership do
    status "invited"
    user
    adventure
  end

  factory :adventure do
    name "Sailing Trip"
    description "Sailing around Boston Harbor"
    location "Boston, MA"
    date Date.new(2015, 06, 25)
    start_time "9:00 AM"
    end_time "5:00 PM"
    public_adventure true
    poll_opened_at nil
  end

  factory :proposed_time do
    sequence(:date) do |n|
      n = n % 32
      Date.new(2016, 07, n)
    end
    sequence(:start_time) do |n|
      n = n % 60
      "10:#{n} AM"
    end
    sequence(:end_time) do |n|
      n = n % 60
      "6:#{n} PM"
    end
    adventure
  end

  factory :proposed_time_vote do
    proposed_time
    adventure_membership
  end

  factory :supply do
    name "Beer"
    adventure
  end
end
