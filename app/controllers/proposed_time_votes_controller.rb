class ProposedTimeVotesController < ApplicationController
  def create
    proposed_time = ProposedTime.find(params[:proposed_time_id])
    adventure_membership = AdventureMembership.find_by(
      adventure: proposed_time.adventure,
      user: current_user
    )
    @vote = ProposedTimeVote.new(
      proposed_time: proposed_time,
      adventure_membership: adventure_membership
    )
    if @vote.save
      flash[:notice] = "Updated Attendance!"
    end

    redirect_to adventure_path(proposed_time.adventure)
  end

  def destroy
    proposed_time = ProposedTime.find(params[:proposed_time_id])
    @vote = ProposedTimeVote.find(params[:id])
    @vote.destroy
    flash[:notice] = "Updated Attendance!"
    redirect_to adventure_path(proposed_time.adventure)
  end
end
