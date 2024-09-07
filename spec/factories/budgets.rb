# frozen_string_literal: true

FactoryBot.define do
  factory :budget do
    start_date { Date.today }
    end_date { Date.today + 1.month }
    association :user
  end
end
