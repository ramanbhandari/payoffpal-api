# frozen_string_literal: true

class CreateBudgetItems < ActiveRecord::Migration[7.1]
  def change
    create_table :budget_items do |t|
      t.references :budget, null: false, foreign_key: true
      t.string :name
      t.decimal :amount
      t.string :category
      t.string :item_type

      t.timestamps
    end
  end
end
