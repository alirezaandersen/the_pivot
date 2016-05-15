Rails.application.routes.draw do
  root to: 'home#index'

  resources :jobs, only: [:index]
  get '/jobs/:title', to: 'jobs#show', as: :job

  get    "companies/pending_companies_approval", to: 'companies#pending_index', as: :companies_applicants
  get    "companies/pending_companies_approval/:id", to: 'companies#pending_show', as: :company_applicants
  resources :companies, only: [:index, :show]
  get  "/submissions", to: 'companies#new', as: :submissions
  post "/companies", to: 'companies#create'
  resources :users, only: [:new, :create]
  get '/search/jobs', to: 'search#show', as: :search_job

  resources :favorites_jobs, only: [:create, :destroy]

  get "/dashboard", to: "users#show"
  get "/dashboard/platform_admin",to: "users#show", as: :platform_admin_dashboard
  get "/dashboard/store_admin", to: "users#show", as: :store_admin_dashboard
  get    "/login", to: "sessions#new", as: :login
  post   "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get    "/about_us", to: 'home#about_us', as: :about_us
  get    "/contact_us", to:'contact_us#new', as: :contact_us
  post   "/contact_us", to:'contact_us#create'
  get    "/contact_us/all", to: 'contact_us#index', as: :customer_inquiries
  get    "/contact_us/:id", to: 'contact_us#show', as: :customer_inquiry
  delete "/contact_us/:id", to: 'contact_us#delete'
  get    "/favorites", to: 'favorites_jobs#show', as: :favorites
end
