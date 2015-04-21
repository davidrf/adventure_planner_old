require "rails_helper"

feature "delete a supply", %{
  As a host,
  I want to delete a supply
  So my friends don't bring unecessary items
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I must be the host of the adventure

  scenario "host can delete a supply" do
    adventure_host_record = FactoryGirl.create(:adventure_host)
    host = adventure_host_record.user
    adventure = adventure_host_record.adventure
    supply = FactoryGirl.create(:supply, adventure: adventure)

    visit root_path
    sign_in_as(host)
    click_link adventure.name
    click_link "Delete Supply"

    expect(page).to have_content("Supply Deleted")
    expect(page).to_not have_content(supply.name)
  end

  scenario "member cannot delete a supply" do
    membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure

    visit root_path
    sign_in_as(user)
    click_link adventure.name

    expect(page).to_not have_content("Delete Supply")
  end
end
