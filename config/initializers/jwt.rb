# frozen_string_literal: true

# JWT Config
module JWTConfig
  module_function

  ACCESS_TOKEN_EXPIRY = 30.minutes
  REFRESH_TOKEN_EXPIRY = 7.days

  def access_token_expiry
    ACCESS_TOKEN_EXPIRY
  end

  def refresh_access_token
    REFRESH_TOKEN_EXPIRY
  end
end
