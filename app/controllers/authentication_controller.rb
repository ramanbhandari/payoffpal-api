# frozen_string_literal: true

# Authentication Controller
class AuthenticationController < ApplicationController
  # we can't authenticate users with token for signup and login
  skip_before_action :authenticate_request, only: %i[register login refresh]

  # POST /register
  def register
    user = User.new(user_params)
    if user.save
      token = generate_token(user)
      refresh_token = generate_refresh_token(user)
      render json: { user:, token:, refresh_token: refresh_token.token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  rescue StandardError => e
    handle_token_creation_error(user, e)
  end

  # POST /login
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = generate_token(user)
      refresh_token = generate_refresh_token(user)
      render json: { user:, token:, refresh_token: refresh_token.token }, status: :ok
    else
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # POST /refresh
  def refresh
    refresh_token = RefreshToken.find_by(token: params[:refresh_token])
    if refresh_token&.expired?
      render json: { errors: 'Refresh token has been expired' }, status: :unauthorized
    else
      user = refresh_token.user
      token = generate_token(user) # access token
      # invalidate the refresh token before we generate a new one
      refresh_token.update!(expires_at: Time.zone.now)
      new_refresh_token = generate_refresh_token(user)
      render json: { token:, refresh_token: new_refresh_token.token }
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end

  def generate_token(user)
    encode_token({ user_id: user.id })
  end

  def handle_token_creation_error(user, error)
    # if there was an error encoding token and user is created (not what we want)
    # destroy it
    user.destroy
    render json: { errors: "Failed to create token:#{error.message}" }, status: :unprocessable_entity
  end

  def generate_refresh_token(user)
    RefreshToken.create!(
      user:,
      token: SecureRandom.hex(64),
      expires_at: JWTConfig.refresh_access_token.from_now
    )
  end
end
