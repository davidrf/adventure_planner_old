require "rails_helper"

feature "user can see this adventure", %{
  As a user,
  I want to see the details about the adventure
  So that I can learn more about the adventure
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I can see public adventures
  # * I must be able to see the adventure name and details
  # * I can see private adventures if I have been invited

  scenario "user can see this adventure" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)

    visit root_path
    sign_in_as(user)
    click_link adventure.name

    expect(page).to have_content(adventure.name)
    expect(page).to have_content(adventure.description)
  end
end
