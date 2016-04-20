Rails.application.routes.draw do

  resources :tasks, only: [:index]
  resources :cart_tasks, only: [:create]
  resources :volunteers, only: [:new]
  
  get "/cart", to: 'cart_tasks#show'
  get "/:name", to: 'cities#show', as: :city

end
