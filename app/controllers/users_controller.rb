# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  # makes sure this endpoint is only accessed by authenticated users
  # before_action :authenticate_request
  # BUT we don't need it since we added it to ApplicationController to apply always except when
  # we tell it to 'skip_before_action'

  # yes return all user info
  def show
    render json: @current_user.as_json(only: %i[id name email]), status: :ok
  end
end
