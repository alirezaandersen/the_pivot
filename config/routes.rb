Rails.application.routes.draw do
  root to: 'home#index'

  resources :tasks, only: [:index, :show]
  resources :cart_tasks, only: [:create, :destroy]
  resources :volunteers, only: [:create, :new, :edit]

  get '/dashboard', to: 'volunteers#show'
  get "/cart", to: 'cart_tasks#show'
  get '/commitments', to: 'volunteer_tasks#show', as: :commitments
  post '/commitments', to: 'volunteer_tasks#create'

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/:name", to: 'cities#show', as: :city

  namespace :admin do
    get '/dashboard', to: 'volunteers#show'
    patch '/dashboard', to: 'volunteers#update'
    get '/edit', to: 'volunteers#edit'
  end

end
