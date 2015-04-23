require "rails_helper"

feature "delete an expense", %{
  As a user,
  I want to delete an expense
  So my the expense is not added to the total
} do
  # Acceptance Criteria
  # * I must be signed in
  # * I must be a member of the adventure
  # * I must have created the expense

  scenario "user can delete an expense" do
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
    click_link "Delete Expense"

    expect(page).to have_content("Expense Deleted")
    expect(page).to_not have_content(expense.name)
  end

  scenario "only expense creator can delete an expense" do
    membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure
    another_membership_record = FactoryGirl.create(:adventure_membership,
      adventure: adventure
    )
    FactoryGirl.create(:expense,
      adventure: adventure,
      adventure_membership: another_membership_record
    )

    visit root_path
    sign_in_as(user)
    click_link adventure.name

    expect(page).to_not have_content("Delete Expense")
  end

  scenario "must be signed in to delete" do
    membership_record = FactoryGirl.create(:adventure_membership)
    adventure = membership_record.adventure
    FactoryGirl.create(:expense,
      adventure: adventure,
      adventure_membership: membership_record
    )

    visit root_path
    click_link adventure.name

    expect(page).to_not have_content("Delete Expense")
  end
end
