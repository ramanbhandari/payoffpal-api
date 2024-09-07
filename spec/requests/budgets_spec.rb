# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Budgets', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { encode_token({ user_id: user.id }) }

  # delete the user created for test
  after do
    User.destroy_all
  end

  describe 'GET /index' do
    context 'new user have not created budget' do
      it 'returns empty [] response' do
        get '/budgets', headers: { 'Authorization': "Bearer #{token}" }
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq('[]')
      end
    end
  end

  describe 'POST /budgets' do
    let(:valid_params) do
      {
        start_date: Date.today,
        end_date: Date.today + 1.month
      }
    end

    it 'returns budget created' do
      post '/budgets', headers: { 'Authorization': "Bearer #{token}" }, params: { budget: valid_params }
      expect(response).to have_http_status(:success)
    end
  end

  # describe 'GET /show' do
  #   it 'returns http success' do
  #     get '/budgets/show'
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET /update' do
  #   it 'returns http success' do
  #     put '/budgets'
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET /destroy' do
  #   it 'returns http success' do
  #     delete '/budgets/:id'
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
