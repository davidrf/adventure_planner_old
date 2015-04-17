class ProposedTimesController < ApplicationController
  def new
    @adventure = Adventure.find(params[:adventure_id])
    @proposed_time = ProposedTime.new
  end

  def create
    @adventure = Adventure.find(params[:adventure_id])
    @adventure.proposed_times.new(proposed_times_params)

    if @adventure.save
      flash[:notice] = "Proposed Time Added!"
      redirect_to adventure_url(@adventure)
    else
      flash[:alert] = "Proposed Time Not Added. Invalid Form Submission."
      render :new
    end
  end

  private

  def proposed_times_params
    params.require(:proposed_time).permit(:date, :start_time, :end_time)
  end
end
