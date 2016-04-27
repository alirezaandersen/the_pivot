Rails.application.routes.draw do
  root to: 'home#index'

  resources :tasks, only: [:index, :show]
  resources :cart_tasks, only: [:create, :destroy]
  resources :volunteers, only: [:create, :new, :edit]

  # resources :commitments, only: [:show, :create]

  get '/dashboard', to: 'volunteers#show'
  get "/cart", to: 'cart_tasks#show'
  
  get '/commitments', to: 'commitments#show', as: :commitments
  post '/commitments', to: 'commitments#create'

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/:name", to: 'cities#show', as: :city
  # get "/:slug", to: 'cities#show', as: :city

  namespace :admin do
    get '/dashboard', to: 'volunteers#show'
    patch '/dashboard', to: 'volunteers#update'
    get '/edit', to: 'volunteers#edit'
    resources :tasks, only: [:new, :create, :edit, :update]
  end

end
