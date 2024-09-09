# frozen_string_literal: true

# Refresh Tokens
class RefreshToken < ApplicationRecord
  belongs_to :user

  validates :token, presence: true, uniqueness: true
  validates :expires_at, presence: true

  def expired?
    Time.zone.now > expires_at
  end
end
