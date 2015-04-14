require "rails_helper"

feature "view all adventures", %{
  As a user,
  I want to see a list of adventures
  So that I can go adventuring with my friends
} do
  # Acceptance Criteria
  # * I can see all adventures on the index page

  scenario "user can see all adventures" do
    adventure = FactoryGirl.create(:adventure)

    visit root_path

    expect(page).to have_content(adventure.name)
  end
end
