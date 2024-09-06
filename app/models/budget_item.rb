# frozen_string_literal: true

class BudgetItem < ApplicationRecord
  belongs_to :budget

  validates :name, :amount, :category, :item_type, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
