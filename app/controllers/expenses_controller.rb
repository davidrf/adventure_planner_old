class ExpensesController < ApplicationController
  def new
    @adventure = Adventure.find(params[:adventure_id])
    @expense = Expense.new
  end

  def edit
    @adventure = Adventure.find(params[:adventure_id])
    @expense = Expense.find(params[:id])
  end

  def create
    @adventure = Adventure.find(params[:adventure_id])
    @expense = Expense.new(expense_params)
    @expense.adventure = @adventure

    if @adventure.hosts.include?(current_user)
      host_record = AdventureHost.find_by(
        user: current_user,
        adventure: @adventure
      )
      @expense.adventure_host = host_record
    else
      membership_record = AdventureMembership.find_by(
        user: current_user,
        adventure: @adventure
      )
      @expense.adventure_membership = membership_record
    end

    if @expense.save
      flash[:notice] = "Expense Added!"
      redirect_to adventure_url(@adventure)
    else
      flash[:alert] = "Expense Not Added. Invalid Form Submission."
      render :new
    end
  end

  def destroy
    @adventure = Adventure.find(params[:adventure_id])
    @expense = Expense.find(params[:id])
    @expense.destroy
    flash[:notice] = "Expense Deleted"
    redirect_to adventure_url(@adventure)
  end

  def update
    @adventure = Adventure.find(params[:adventure_id])
    @expense = Expense.find(params[:id])

    if @expense.update(expense_params)
      flash[:notice] = "Expense Updated!"
      redirect_to adventure_url(@adventure)
    else
      flash[:alert] = "Expense Not Updated. Invalid Form Submission."
      render :edit
    end
  end

  private

  def expense_params
    permitted_params = params.require(:expense).permit(:name, :cost_in_cents)
    Expense.convert_cost_in_cents_to_float(permitted_params)
  end
end
