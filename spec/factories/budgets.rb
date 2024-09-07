# frozen_string_literal: true

FactoryBot.define do
  factory :budget do
    start_date { Time.zone.today }
    end_date { Time.zone.today + 1.month }
    association :user
  end
end
