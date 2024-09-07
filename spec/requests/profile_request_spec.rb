# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profile', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { encode_token({ user_id: user.id }) }

  # delete the user created for test
  after do
    User.destroy_all
  end

  describe 'GET /profile' do
    context 'with valid token' do
      it 'returns users profile information' do
        get '/profile', headers: { Authorization: "Bearer #{token}" }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include(user.name)
        expect(response.body).to include(user.email)
        expect(response.body).not_to include(user.password_digest)
      end
    end

    context 'with invalid token' do
      it 'returns an unauthorized error' do
        get '/profile', headers: { Authorization: 'Bearer invalid_token' }

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'without token' do
      it 'returns an unauthorized error' do
        get '/profile'

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
