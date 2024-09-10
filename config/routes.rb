# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # trigger 'register' & 'signup' actions from AuthenticationController
  post '/register', to: 'authentication#register'
  post '/login', to: 'authentication#login'
  post '/refresh', to: 'authentication#refresh'
  # trigger 'show' action from UsersController
  get '/profile', to: 'users#show'

  resources :budgets, only: %i[index create show update destroy] do
    # Nested route for budget items
    resources :budget_items, only: %i[create update destroy]
  end
end
