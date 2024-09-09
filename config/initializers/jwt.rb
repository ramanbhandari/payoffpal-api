# frozen_string_literal: true

# JWT Config
module JWTConfig
  module_function

  ACCESS_TOKEN_EXPIRY = 30.minutes
  def access_token_expiry
    ACCESS_TOKEN_EXPIRY
  end
end
