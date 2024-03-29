require "rails_helper"

feature "view adventure details", %{
  As a user,
  I want to create an adventure
  So that I can tell my friends about it
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I must specify the name, description
  # * I can optionally give the location, start and end time,
  #   and set it as private.

  scenario "user can create an adventure" do
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
    select "Yes", from: "Public Adventure?"
    click_button "Create Adventure!"

    expect(page).to have_content(adventure.name)
    expect(page).to have_content(adventure.description)
    expect(page).to have_content(adventure.location)
    expect(page).to have_content(adventure.date)
    expect(page).to have_content(adventure.start_time)
    expect(page).to have_content(adventure.end_time)
    expect(AdventureHost.first.user).to eq(user)
  end

  scenario "user does not input required information" do
    user = FactoryGirl.create(:user)

    visit root_path
    sign_in_as(user)
    click_link "Host An Adventure!"
    click_button "Create Adventure!"

    expect(page).to have_content("Adventure Not Created. Invalid Form Submission.")
  end

  scenario "user not signed in cannot host an adventure" do
    visit root_path

    expect(page).to_not have_content("Host An Adventure!")
  end
end
