Rails.application.routes.draw do
  root to: 'home#index'

  resources :jobs, only: [:index]
  get '/jobs/:title', to: 'jobs#show', as: :job

  resources :companies, only: [:index, :show]
  resources :users, only: [:new, :create]
  get '/search/jobs', to: 'search#show', as: :search_job

  get "/dashboard", to: "users#show"

  get    "/login", to: "sessions#new", as: :login
  post   "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get    "/favorites", to: 'users_jobs#show', as: :favorites
end
