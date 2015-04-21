require "rails_helper"

feature "assign user to a supply", %{
  As a member of the adventure,
  I want to volunteer to bring a supply
  So I can help out with everything that is needed
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I must be a member of the adventure
  # * I can unassign myself from the supply
  # * Only one user can be assigned to a supply

  scenario "host can volunteer to bring supply" do
    adventure_host_record = FactoryGirl.create(:adventure_host)
    host = adventure_host_record.user
    adventure = adventure_host_record.adventure
    supply = FactoryGirl.create(:supply, adventure: adventure)

    visit root_path
    sign_in_as(host)
    click_link adventure.name
    click_link "I Can Bring This!"

    expect(page).to have_content("You Are Now In Charge Of Bringing This Supply!")
  end

  scenario "member can volunteer to bring supply" do
    membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure
    supply = FactoryGirl.create(:supply, adventure: adventure)

    visit root_path
    sign_in_as(user)
    click_link adventure.name
    click_link "I Can Bring This!"

    expect(page).to have_content("You Are Now In Charge Of Bringing This Supply!")
  end

  scenario "member can unassign themselves" do
    membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure
    supply = FactoryGirl.create(:supply, adventure: adventure, adventure_membership: membership_record)

    visit root_path
    sign_in_as(user)
    click_link adventure.name
    click_link "I Cannot Bring This"

    expect(page).to have_content("You Are No Longer Bringing This Supply")
    expect(page).to have_content("I Can Bring This!")
  end

  scenario "only one member can bring a supply" do
    membership_record = FactoryGirl.create(:adventure_membership)
    other_membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure
    supply = FactoryGirl.create(:supply, adventure: adventure, adventure_membership: other_membership_record)

    visit root_path
    sign_in_as(user)
    click_link adventure.name

    expect(page).to_not have_content("I Can Bring This!")
  end
end
