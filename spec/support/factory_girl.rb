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
    date Date.new(2015,06,25)
    start_time "9:00 AM"
    end_time "5:00 PM"
    public_adventure true
    before(:create) do |adventure|
      user = FactoryGirl.create(:user)
      adventure.adventure_hosts << FactoryGirl.build(:adventure_host,
        user: user,
        adventure: adventure
      )
    end
  end
end
