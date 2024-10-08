# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  before_action :authenticate_request

  def encode_token(payload)
    payload[:exp] = (Time.zone.now + JWTConfig.access_token_expiry).to_i
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base).first
  rescue JWT::ExpiredSignature
    raise JWT::ExpiredSignature, 'Token has expired, please log in again'
  rescue JWT::DecodeError
    nil
  end

  def authenticate_request
    token = request.headers['Authorization']&.split&.last
    decoded_token = decode_token(token)

    if decoded_token
      @current_user = User.find_by(id: decoded_token['user_id'])
    else
      render json: { errors: 'Not Authorized' }, status: :unauthorized
    end
  rescue JWT::ExpiredSignature => e
    render json: { errors: e.message }, status: :unauthorized
  end
end
