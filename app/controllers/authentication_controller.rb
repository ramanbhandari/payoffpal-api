# frozen_string_literal: true

class AuthenticationController < ApplicationController
  # we can't authenticate users with token for signup and login
  skip_before_action :authenticate_request, only: %i[register login]

  def register
    user = User.new(user_params)
    if user.save
      begin
        token = encode_token({ user_id: user.id })
        render json: { user: user, token: token }, status: :created
      # if there was an error encoding token and user is created (not what we want)
      # destroy it
      rescue StandardError => e
        user.destroy
        render json: { errors: "Failed to create token#{e.message}" }, status: :unprocessable_entity
      end
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { user: user, token: token }, status: :ok
    else
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
