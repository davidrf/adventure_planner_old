require "rails_helper"

feature "proposed time votes", %{
  As a host,
  I want to vote on a proposed time
  So that I can influence the final date and time for the adventure
} do
  # Acceptance Criteria
  # * I must be a member of the adventure
  # * I can only vote once for each proposed time

  scenario "user can vote on a proposed time" do
    membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure
    adventure.update_attribute(:poll_opened_at, DateTime.now)
    proposed_time = FactoryGirl.create(:proposed_time, adventure: adventure)

    visit root_path
    sign_in_as(user)
    click_link adventure.name
    click_link "Can Attend"

    expect(page).to have_content("Updated Attendance!")
    expect(proposed_time.votes.count).to eq(1)
  end

  scenario "user can take back vote on a proposed time" do
    membership_record = FactoryGirl.create(:adventure_membership)
    user = membership_record.user
    adventure = membership_record.adventure
    adventure.update_attribute(:poll_opened_at, DateTime.now)
    proposed_time = FactoryGirl.create(:proposed_time, adventure: adventure)

    visit root_path
    sign_in_as(user)
    click_link adventure.name
    click_link "Can Attend"
    click_link "Cannot Attend"

    expect(page).to have_content("Updated Attendance!")
    expect(proposed_time.votes.count).to eq(0)
  end

  scenario "vote count is increased" do
    adventure = FactoryGirl.create(:adventure)
    adventure.update_attribute(:poll_opened_at, DateTime.now)
    membership_record_1 = FactoryGirl.create(:adventure_membership,
      adventure: adventure
    )
    membership_record_2 = FactoryGirl.create(:adventure_membership,
      adventure: adventure
    )
    proposed_time = FactoryGirl.create(:proposed_time,
      adventure: adventure
    )
    FactoryGirl.create(:proposed_time_vote,
      proposed_time: proposed_time,
      adventure_membership: membership_record_2
    )
    user = membership_record_1.user

    visit root_path
    sign_in_as(user)
    click_link adventure.name
    click_link "Can Attend"

    expect(page).to have_content("Updated Attendance!")
    expect(proposed_time.votes.count).to eq(2)
  end
end
