# require "rails_helper"
#
# feature "host can create a time poll", %{
#   As a host,
#   I want to create a time poll
#   So that my members can choose the most convenient time
# } do
#   # Acceptance Criteria
#   # * I must be signed in
#   # * I must be the host of the adventure
#   # * i must specify a date
#   # * I can optionally specify a time
#
#   scenario "host creates a time poll" do
#     adventure_host_record = FactoryGirl.create(:adventure_host)
#     host = adventure_host_record.user
#     adventure = adventure_host_record.adventure
#     poll = FactoryGirl.build(:time_poll_with_times)
#
#     visit root_path
#     sign_in_as(host)
#     click_link adventure.name
#     click_link "Create Time Poll"
#     fill_in "Date 1", with: poll.proposed_times.first.date
#     fill_in "Start Time 1", with: poll.proposed_times.first.start_time
#     fill_in "End Time 1", with: poll.proposed_times.first.end_time
#     click_button "Create Time Poll"
#
#     expect(page).to have_content(poll.proposed_times.first.data)
#     expect(page).to have_content(adventure.description)
#   end
# end
