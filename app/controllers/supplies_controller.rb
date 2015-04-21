class SuppliesController < ApplicationController
  def new
    @adventure = Adventure.find(params[:adventure_id])
    @supply = Supply.new
  end

  def create
    @adventure = Adventure.find(params[:adventure_id])
    @supply = Supply.new(supplies_params)
    @supply.adventure = @adventure

    if @supply.save
      flash[:notice] = "Supply Added!"
      redirect_to adventure_url(@adventure)
    else
      flash[:alert] = "Supply Not Added. Invalid Form Submission."
      render :new
    end
  end

  def destroy
    @adventure = Adventure.find(params[:adventure_id])
    @supply = Supply.find(params[:id])
    @supply.destroy
    flash[:notice] = "Supply Deleted"
    redirect_to adventure_url(@adventure)
  end

  def update
    @adventure = Adventure.find(params[:adventure_id])
    @supply = Supply.find(params[:id])
    if @supply.adventure_membership || @supply.adventure_host
      @supply.adventure_membership = nil
      @supply.adventure_host = nil
      flash[:notice] = "You Are No Longer Bringing This Supply"
    else
      membership_record = AdventureMembership.find_by(
        user: current_user,
        adventure: @adventure
      )
      if membership_record
        @supply.adventure_membership = membership_record
      else
        host_record = AdventureHost.find_by(
          user: current_user,
          adventure: @adventure
        )
        @supply.adventure_host = host_record
      end
      flash[:notice] = "You Are Now In Charge Of Bringing This Supply!"
    end
    @supply.save
    redirect_to adventure_url(@adventure)
  end

  private

  def supplies_params
    params.require(:supply).permit(:name)
  end
end
