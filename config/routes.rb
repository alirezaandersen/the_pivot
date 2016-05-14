Rails.application.routes.draw do
  root to: 'home#index'

  resources :jobs, only: [:index]
  get '/jobs/:title', to: 'jobs#show', as: :job

  resources :companies, only: [:index, :show]
  resources :users, only: [:new, :create]
  get '/search/jobs', to: 'search#show', as: :search_job

  resources :favorites_jobs, only: [:create, :destroy]
  resources :users_jobs, only: [:create]
  get '/submissions', to: "users_jobs#show", as: :my_jobs

  get "/dashboard", to: "users#show"

  get    "/login", to: "sessions#new", as: :login
  post   "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get    "/about_us", to: 'home#about_us', as: :about_us
  get    "/contact_us", to:'contact_us#new', as: :contact_us
  post    "/contact_us", to:'contact_us#create'
  get    "/favorites", to: 'favorites_jobs#show', as: :favorites
end
