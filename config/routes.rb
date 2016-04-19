Rails.application.routes.draw do

  resources :tasks, only: [:index]

  # resources :cities, param: :name
  get "/:name", to: 'cities#show'

end
