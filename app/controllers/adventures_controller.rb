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
      redirect_to adventure_url(@adventure)
    else
      flash[:alert] = "Adventure Not Created. Invalid Form Submission."
      @public_adventure_dropdown = [["Yes", true], ["No", false]]
      render :new
    end
  end

  def edit
    @adventure = Adventure.find(params[:id])
    @public_adventure_dropdown = [["Yes", true], ["No", false]]
  end

  def update
    @adventure = Adventure.find(params[:id])

    if @adventure.update(adventure_params)
      flash[:notice] = "Adventure Updated!"
      redirect_to adventure_url(@adventure)
    else
      flash[:alert] = "Adventure Not Updated. Invalid Form Submission."
      @public_adventure_dropdown = [["Yes", true], ["No", false]]
      render :edit
    end
  end

  def destroy
    @adventure = Adventure.find(params[:id])
    @adventure.destroy
    flash[:notice] = "Adventure Cancelled."
    redirect_to adventures_url
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
      :public_adventure,
      :poll_opened_at
    )
  end
end
