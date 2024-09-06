# frozen_string_literal: true

module AuthHelper
  def encode_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end
