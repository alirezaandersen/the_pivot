Rails.application.routes.draw do

  resources :tasks, only: [:index]
  resources :cart_tasks, only: [:create]
  resources :volunteers, only: [:create, :new]

  get '/dashboard', to: 'volunteers#show'
  get "/cart", to: 'cart_tasks#show'

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/:name", to: 'cities#show', as: :city

end
