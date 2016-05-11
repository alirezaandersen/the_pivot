Rails.application.routes.draw do
  root to: 'home#index'

  resources :jobs, only: [:index]
  get '/jobs/:title', to: 'jobs#show', as: :job

  resources :companies, only: [:index]

  get "/login", to: "sessions#new"
  get "/favorites", to: 'users_jobs#show', as: :favorites


end
