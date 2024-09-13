# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Login API', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { encode_token({ user_id: user.id }) }

  # delete the user created for test
  after do
    User.destroy_all
  end

  path '/login' do
    post 'User login' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :login_details, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'user@example.com' },
          password: { type: :string, example: 'password' }
        },
        required: %w[email password]
      }

      response '200', 'Login successful' do
        let(:login_details) { { email: user.email, password: user.password } }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:login_details) { { email: user.email, password: 'wrong_password' } }
        run_test!
      end
    end
  end
end
