require "rails_helper"

feature "edit an expense", %{
  As a user,
  I want to edit an expense,
  So I can fix any errors
} do
  # Acceptance Criteria
  # * I must be the expense owner
  # * I must specify the name and cost of the supply

  scenario "expense can be edited by its creator" do
    membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure
    expense = FactoryGirl.create(:expense,
      adventure: adventure,
      adventure_membership: membership_record
    )

    visit root_path
    sign_in_as(user)
    click_link adventure.name
    click_link "Edit Expense"
    fill_in "Name", with: "Food"
    fill_in "Cost", with: "10.0"
    click_button "Submit Expense!"

    expect(page).to have_content("Expense Updated!")
    expect(page).to have_content("Food")
    expect(page).to have_content("10.0")
  end

  scenario "invalid input filled in" do
    membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure
    expense = FactoryGirl.create(:expense,
      adventure: adventure,
      adventure_membership: membership_record
    )

    visit root_path
    sign_in_as(user)
    click_link adventure.name
    click_link "Edit Expense"
    fill_in "Name", with: ""
    fill_in "Cost", with: ""
    click_button "Submit Expense!"

    expect(page).to have_content("Expense Not Updated. Invalid Form Submission.")
  end

  scenario "expense can only be edited by its creator" do
    membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure
    another_membership_record = FactoryGirl.create(:adventure_membership,
      adventure: adventure
    )
    expense = FactoryGirl.create(:expense,
      adventure: adventure,
      adventure_membership: another_membership_record
    )

    visit root_path
    sign_in_as(user)
    click_link adventure.name

    save_and_open_page
    expect(page).to_not have_content("Edit Expense")
  end

  scenario "must be signed-in to edit" do
    membership_record = FactoryGirl.create(:adventure_membership)
    adventure = membership_record.adventure
    expense = FactoryGirl.create(:expense,
      adventure: adventure,
      adventure_membership: membership_record
    )

    visit root_path
    click_link adventure.name

    expect(page).to_not have_content("Edit Expense")
  end
end
