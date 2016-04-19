Rails.application.routes.draw do

  resources :tasks, only: [:index]
  resources :cart_tasks, only: [:create]
  get "/:name", to: 'cities#show', as: :city

  # resources :cities, only:[:show], param: :name, as

end
