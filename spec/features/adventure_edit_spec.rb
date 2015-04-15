require "rails_helper"

feature "edit adventure details", %{
  As a host,
  I want to edit an adventure
  So that I can fix any erroneous information
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I must specify the name, description
  # * I can optionally give the location, start and end time

  scenario "host can edit an adventure" do
    adventure_host_record = FactoryGirl.create(:adventure_host)
    host = adventure_host_record.user
    adventure = adventure_host_record.adventure

    visit root_path
    sign_in_as(host)
    click_link adventure.name
    click_link "Update Adventure!"
    fill_in "Name", with: "Yacht Week"
    click_button "Update Adventure!"

    expect(page).to have_content("Adventure Updated!")
    expect(page).to have_content("Yacht Week")
    expect(page).to have_content(adventure.description)
    expect(page).to have_content(adventure.location)
    expect(page).to have_content(adventure.date)
    expect(page).to have_content(adventure.start_time)
    expect(page).to have_content(adventure.end_time)
  end

  scenario "host does not input required information" do
    adventure_host_record = FactoryGirl.create(:adventure_host)
    host = adventure_host_record.user
    adventure = adventure_host_record.adventure

    visit root_path
    sign_in_as(host)
    click_link adventure.name
    click_link "Update Adventure!"
    fill_in "Name", with: ""
    click_button "Update Adventure!"

    expect(page).to have_content("Adventure Not Updated. Invalid Form Submission.")
  end

  scenario "non-host user cannot edit adventure" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)

    visit root_path
    sign_in_as(user)
    click_link adventure.name

    expect(page).to_not have_content("Update Adventure!")
  end

  scenario "user not signed in cannot edit an adventure" do
    adventure = FactoryGirl.create(:adventure)

    visit root_path
    click_link adventure.name

    expect(page).to_not have_content("Update Adventure!")
  end
end
