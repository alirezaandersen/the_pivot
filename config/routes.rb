Rails.application.routes.draw do
  root to: 'home#index'
  resources :tasks, only: [:index]
  resources :cart_tasks, only: [:create, :destroy]
  get "/cart", to: 'cart_tasks#show'
  get "/:name", to: 'cities#show', as: :city
end
