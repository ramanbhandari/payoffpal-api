# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Register API', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { encode_token({ user_id: user.id }) }

  # delete the user created for test
  after do
    User.destroy_all
  end

  path '/register' do
    post 'User Register' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :register_details, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'John Doe' },
          email: { type: :string, example: 'user@example.com' },
          password: { type: :string, example: 'password' }
        },
        required: %w[name email password]
      }

      response '422', 'Unauthorized' do
        let(:register_details) { { name: user.name, email: user.email, password: 'wrong_password' } }
        run_test!
      end

      response '422', 'Invalid' do
        let(:register_details) { { name: user.name, email: user.email, password: 'Password123Sd' } }
        run_test!
      end
    end
  end
end
