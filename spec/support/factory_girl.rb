require "factory_girl"

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

  factory :adventure do
    name "Sailing Trip"
    description "Sailing around Boston Harbor"
    location "Boston, MA"
    date "06/25/2015"
    start_time "9:00 AM"
    access "public"
    password ""
    user
  end
end
