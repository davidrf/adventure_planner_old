require "rails_helper"

feature "view adventure details", %{
  As a user,
  I want to create an adventure
  So that I can tell my friends about it
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I can see public adventures
  # * I can see private adventures if I have been invited
  # * I must be able to see the adventure name and details

  scenario "view index page" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)

    visit root_path
    sign_in_as(user)
    click_link adventure.name

    expect(page).to have_content(adventure.name)
    expect(page).to have_content(adventure.description)
  end
end
