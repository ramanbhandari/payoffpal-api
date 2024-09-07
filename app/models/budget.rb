# frozen_string_literal: true

# Budget
class Budget < ApplicationRecord
  belongs_to :user
  has_many :budget_items, dependent: :destroy

  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    return unless end_date < start_date

    errors.add(:end_date, 'must be after the start date')
  end
end
