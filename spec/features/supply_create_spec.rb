require "rails_helper"

feature "create a supply", %{
  As a host,
  I want to create a supply
  So my friends can see what is needed for the adventure
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I must be the host of the adventure
  # * I must specify the name

  scenario "host can create a supply" do
    adventure_host_record = FactoryGirl.create(:adventure_host)
    host = adventure_host_record.user
    adventure = adventure_host_record.adventure
    supply = FactoryGirl.build(:supply, adventure: adventure)

    visit root_path
    sign_in_as(host)
    click_link adventure.name
    click_link "Add a Supply!"
    fill_in "Name", with: supply.name
    click_button "Add Supply!"

    expect(page).to have_content("Supply Added!")
    expect(page).to have_content(supply.name)
  end

  scenario "required fields not filled in" do
    adventure_host_record = FactoryGirl.create(:adventure_host)
    host = adventure_host_record.user
    adventure = adventure_host_record.adventure
    supply = FactoryGirl.build(:supply, adventure: adventure)

    visit root_path
    sign_in_as(host)
    click_link adventure.name
    click_link "Add a Supply!"
    click_button "Add Supply!"

    expect(page).to have_content("Supply Not Added. Invalid Form Submission.")
  end

  scenario "user cannot create a supply" do
    membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure

    visit root_path
    sign_in_as(user)
    click_link adventure.name

    expect(page).to_not have_content("Add a Supply!")
  end
end
