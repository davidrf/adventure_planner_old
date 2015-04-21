require "rails_helper"

feature "user can see all supplies", %{
  As a user,
  I want to see a list of supplies
  So that I can see if there is anything I can bring
} do
  # Acceptance Criteria
  # * I can see all supplies on the adventure show page

  scenario "user can see all supplies" do
    user = FactoryGirl.create(:user)
    supply = FactoryGirl.create(:supply)
    adventure = supply.adventure

    visit root_path
    sign_in_as(user)
    click_link adventure.name

    expect(page).to have_content(supply.name)
  end
end
