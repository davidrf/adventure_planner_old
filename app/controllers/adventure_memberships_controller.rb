class AdventureMembershipsController < ApplicationController
  def create
    @adventure = Adventure.find(params[:adventure_id])
    @adventure_membership = AdventureMembership.new
    @adventure_membership.user = current_user
    @adventure_membership.adventure = @adventure

    if @adventure_membership.save
      flash[:notice] = "You Have Joined The Adventure!"
    else
      flash[:alert] = "You Must Sign In To Join The Adventure!"
    end

    redirect_to adventure_path(@adventure)
  end
end
