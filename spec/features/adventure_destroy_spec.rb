require "rails_helper"

feature "host cancels adventure", %{
  As a host,
  I want to cancel an adventure
  So people do not show up to an even that is not happening
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I must be a host of the adventure

  scenario "user can delete an adventure" do
    host = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)
    adventure_host_record = FactoryGirl.create(:adventure_host,
      user: host,
      adventure: adventure
    )

    visit root_path
    sign_in_as(host)
    click_link adventure.name
    click_link "Cancel Adventure"

    expect(page).to have_content("Adventure Cancelled.")
    expect(Adventure.count).to eq(0)
  end

  scenario "user can delete an adventure" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)

    visit root_path
    sign_in_as(user)
    click_link adventure.name

    expect(page).to_not have_content("Cancel Adventure")
  end
end
