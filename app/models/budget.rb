# frozen_string_literal: true

class Budget < ApplicationRecord
  belongs_to :user
  has_many :budget_items, dependent: :destroy

  validates :start_date, :end_date, presence: true
end
