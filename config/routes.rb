Rails.application.routes.draw do
  root to: 'home#index'

  resources :jobs, only: [:index]
  resources :companies, only: [:index]
  resources :users, only: [:new, :create, :show]

  get    "/dashboard", to: "users#show"

  get    "/login", to: "sessions#new", as: :login
  post   "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get    "/favorites", to: 'users_jobs#show', as: :favorites


end
