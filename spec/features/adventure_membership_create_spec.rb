require "rails_helper"

feature "user can join adventure", %{
  As a user,
  I want to join an adventure
  So that my friends can adventure with me
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I must be able to invite friends from the adventure show page

  scenario "user can join adventure" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)

    visit root_path
    sign_in_as(user)
    click_link adventure.name
    click_link "Join The Adventure!"

    expect(page).to have_content("You Have Joined The Adventure!")
    expect(adventure.members.count).to eq(1)
  end

  scenario "host cannot join adventure" do
    adventure_host_record = FactoryGirl.create(:adventure_host)
    host = adventure_host_record.user
    adventure = adventure_host_record.adventure

    visit root_path
    sign_in_as(host)
    click_link adventure.name

    expect(page).to_not have_content("Join The Adventure!")
  end

  scenario "user cannot join adventure twice" do
    adventure_member_record = FactoryGirl.create(:adventure_membership)
    member = adventure_member_record.user
    adventure = adventure_member_record.adventure

    visit root_path
    sign_in_as(member)
    click_link adventure.name

    expect(page).to_not have_content("Join The Adventure!")
  end

  scenario "user not signed-in cannot join adventure" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)

    visit root_path
    click_link adventure.name
    click_link "Join The Adventure!"

    expect(page).to have_content("You Must Sign In To Join The Adventure!")
  end
end
