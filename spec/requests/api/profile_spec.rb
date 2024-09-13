# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Profile API', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { encode_token({ user_id: user.id }) }

  # delete the user created for test
  after do
    User.destroy_all
  end
  path '/profile' do
    get 'Retrieves user profile information' do
      tags 'Profile'
      security [Bearer: []]
      produces 'application/json'

      response '200', 'User profile retrieved successfully' do
        let(:Authorization) { token }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['name']).to eq(user.name)
          expect(data['email']).to eq(user.email)
          expect(data.key?('password_digest')).to be_falsey
        end
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { 'Bearer invalid_token' }
        run_test!
      end

      response '401', 'Unauthorized without token' do
        let(:Authorization) { nil }
        run_test!
      end
    end
  end
end
