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

  scenario "user not signed-in cannot join adventure" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)

    visit root_path
    click_link adventure.name
    click_link "Join The Adventure!"

    expect(page).to have_content("Cannot Join Adventure")
  end
end
