require "rails_helper"

feature "user can see all expenses", %{
  As a user,
  I want to see a list of expenses
  So that I can see what was bought and what I owe
} do
  # Acceptance Criteria
  # * I can see all expenses on the adventure show page
  # * I can see what I owe

  scenario "user can see all expenses" do
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

    expect(page).to have_content(expense.name)
    expect(page).to have_content(expense.cost)
  end
end
