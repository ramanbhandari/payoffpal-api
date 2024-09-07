# frozen_string_literal: true

# Budget Items Controller
class BudgetItemsController < ApplicationController
  before_action :set_budget, only: %i[create update destroy]

  def create
    budget_item = @budget.budget_items.build(budget_item_params)
    if budget_item.save
      render json: budget_item, status: :created
    else
      render json: { errors: budget_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    budget_item = @budget.budget_items.find(params[:id])
    if budget_item.update(budget_item_params)
      render json: budget_item, status: :ok
    else
      render json: { errors: budget_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    budget_item = @budget.budget_items.find(params[:id])
    if budget_item
      budget_item.destroy
      render json: { message: 'Budget item deleted' }, status: :ok
    else
      render json: { error: 'Budget item not found' }, status: :not_found
    end
  end

  private

  def set_budget
    @budget = @current_user.budgets.find(params[:budget_id])
    render json: { error: 'Budget not found' }, status: :not_found unless @budget
  end

  def budget_item_params
    params.require(:budget_item).permit(:name, :amount, :category, :item_type)
  end
end
