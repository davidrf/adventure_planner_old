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

  private

  def supplies_params
    params.require(:supply).permit(:name)
  end
end
