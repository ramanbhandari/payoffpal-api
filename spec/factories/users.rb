# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Alisha Doe' }
    email { 'alisha.doe@example.com' }
    password { 'Password123' }
  end
end
