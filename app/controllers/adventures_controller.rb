class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.all
  end

  def show
    @adventure = Adventure.find(params[:id])
  end

  def new
    @adventure = Adventure.new
    @public_adventure_dropdown = [["Yes", true], ["No", false]]
  end

  def create
    @adventure = Adventure.new(adventure_params)
    @adventure.adventure_hosts.new(user: current_user)

    if @adventure.save
      flash[:notice] = "Adventure Created!"
      redirect_to adventure_path(@adventure)
    else
      flash[:alert] = "Adventure Not Created. Invalid Form Submission."
      render :new
    end
  end

  private

  def adventure_params
    params.require(:adventure).permit(
      :name,
      :description,
      :location,
      :date,
      :start_time,
      :end_time,
      :public_adventure
    )
  end
end
