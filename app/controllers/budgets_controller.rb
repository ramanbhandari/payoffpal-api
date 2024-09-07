# frozen_string_literal: true

class BudgetsController < ApplicationController
  # GET /budgets
  def index
    @budgets = @current_user.budgets
    render json: @budgets, status: :ok
  end

  # POST /budgets
  def create
    budget = @current_user.budgets.build(budget_params)
    if budget.save
      render json: budget, status: :created
    else
      render json: { errors: budget.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /budgets/:id
  def show
    budget = @current_user.budgets.find_by(id: params[:id])
    if budget
      render json: budget.as_json(include: :budget_items), status: :ok
    else
      render json: { error: 'Budget not found' }, status: :not_found
    end
  end

  # PUT /budgets/:id
  def update
    begin
      budget = @current_user.budgets.find_by(id: params[:id])
      if budget.update(budget_params)
        render json: budget
      else
        render json: budget.errors, status: :unprocessable_entity
      end
    rescue Exception
      render json: { error: 'Budget not found' }, status: :not_found
    end
  end

  # DELETE /budgets/:id
  def destroy
    budget = @current_user.budgets.find_by(id: params[:id])
    if budget
      budget.destroy
      render json: { message: 'Budget deleted'}, status: :ok
    else
      render json: { error: 'Budget not found' }, status: :not_found
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:start_date, :end_date)
  end
end
