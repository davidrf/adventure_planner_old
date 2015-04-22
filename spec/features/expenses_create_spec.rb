require "rails_helper"

feature "create an expense", %{
  As a user,
  I want to create an expense,
  So I can get credit with how much money I have contributed
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I must be part of the adventure
  # * I must specify the name and cost of the supply

  scenario "adventure member can create an expense" do
    membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure
    expense = FactoryGirl.build(:expense)

    visit root_path
    sign_in_as(user)
    click_link adventure.name
    click_link "Add An Expense!"
    fill_in "Name", with: expense.name
    fill_in "Cost", with: expense.cost
    click_button "Submit Expense!"

    expect(page).to have_content("Expense Added!")
    expect(page).to have_content(expense.name)
    expect(page).to have_content(expense.cost)
  end

  scenario "required fields not filled in" do
    membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure

    visit root_path
    sign_in_as(user)
    click_link adventure.name
    click_link "Add An Expense!"
    click_button "Submit Expense!"

    expect(page).to have_content("Expense Not Added. Invalid Form Submission.")
  end

  scenario "only adventure members can add an expense" do
    adventure = FactoryGirl.create(:adventure)
    user = FactoryGirl.create(:user)

    visit root_path
    sign_in_as(user)
    click_link adventure.name

    expect(page).to_not have_content("Add An Expense!")
  end
end
