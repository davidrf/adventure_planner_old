require "rails_helper"

feature "view adventure details", %{
  As a user,
  I want to create an adventure
  So that I can tell my friends about it
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I must specify the name, description
  # * I can optionally give the location, start and end time, and set it as private.

  scenario "user creates adventure" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.build(:adventure)

    visit root_path
    sign_in_as(user)
    click_link "Host An Adventure!"
    fill_in "Name", with: adventure.name
    fill_in "Description", with: adventure.description
    fill_in "Location", with: adventure.location
    fill_in "Date", with: adventure.date
    fill_in "Start Time", with: adventure.start_time
    fill_in "End Time", with: adventure.end_time
    click_button "Create Adventure!"

    expect(page).to have_content(adventure.name)
    expect(page).to have_content(adventure.description)
    expect(page).to have_content(adventure.location)
    expect(page).to have_content(adventure.date)
    expect(page).to have_content(adventure.start_time)
    expect(page).to have_content(adventure.end_time)
    expect(AdventureHost.first.user).to eq(user)
  end
end
