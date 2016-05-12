Rails.application.routes.draw do
  root to: 'home#index'

  resources :jobs, only: [:index]
  get '/jobs/:title', to: 'jobs#show', as: :job

  resources :companies, only: [:index, :show]
  resources :users, only: [:new, :create]
  resources :favorites_jobs, only: [:create, :destroy]

  get    "/dashboard", to: "users#show"

  get    "/login", to: "sessions#new", as: :login
  post   "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get    "/favorites", to: 'favorites_jobs#show', as: :favorites
end
