require "rails_helper"

feature "host can create a proposed time", %{
  As a host,
  I want to create a proposed time
  So that I can see if members can attend at that time
} do
  # Acceptance Criteria
  # * I must be the host of the adventure
  # * I must specify a date, start_time, and end_time

  scenario "host creates a time poll" do
    adventure_host_record = FactoryGirl.create(:adventure_host)
    host = adventure_host_record.user
    adventure = adventure_host_record.adventure
    proposed_time = FactoryGirl.build(:proposed_time, adventure: adventure)

    visit root_path
    sign_in_as(host)
    click_link adventure.name
    click_link "Open Time Poll"
    click_link "Propose A Time"
    fill_in "Date", with: proposed_time.date
    fill_in "Start Time", with: proposed_time.start_time
    fill_in "End Time", with: proposed_time.end_time
    click_button "Propose Time"

    expect(page).to have_content("Proposed Time Added!")
    expect(page).to have_content(proposed_time.date)
    expect(page).to have_content(proposed_time.start_time)
    expect(page).to have_content(proposed_time.end_time)
  end

  scenario "required fields not filled in" do
    adventure_host_record = FactoryGirl.create(:adventure_host)
    host = adventure_host_record.user
    adventure = adventure_host_record.adventure
    proposed_time = FactoryGirl.build(:proposed_time, adventure: adventure)

    visit root_path
    sign_in_as(host)
    click_link adventure.name
    click_link "Open Time Poll"
    click_link "Propose A Time"
    click_button "Propose Time"

    expect(page).to have_content("Proposed Time Not Added. Invalid Form Submission.")
  end
end
