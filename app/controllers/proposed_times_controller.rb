class ProposedTimesController < ApplicationController
  def new
    @adventure = Adventure.find(params[:adventure_id])
    @proposed_time = ProposedTime.new
  end

  def create
    @adventure = Adventure.find(params[:adventure_id])
    @proposed_time = ProposedTime.new(proposed_times_params)
    @proposed_time.adventure = @adventure


    if @proposed_time.save
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
