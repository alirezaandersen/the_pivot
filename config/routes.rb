Rails.application.routes.draw do
  root to: 'home#index'

  resources :jobs, only: [:index]
  get '/jobs/:title', to: 'jobs#show', as: :job

  get "/companies/inactive_companies", to: 'companies#inactive_companies', as: :inactive_companies
  get "/companies/active_companies", to: 'companies#active_companies', as: :active_companies
  get "/companies/activate/:company_name", to: 'companies#activate_company', as: :activate_company
  get "/companies/inactivate/:company_name", to: 'companies#inactivate_company', as: :inactivate_company
  resources :companies, only: [:index, :show]

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

  get    "submissions", to: 'submissions#new', as: :submissions
  post   "submissions", to: 'submissions#create'
  get    "submissions/pending", to: 'submissions#index', as: :submissions_status
  get    "submissions/:company_name", to: 'submissions#show', as: :company_submission_status
  get    "submissions/:company_name/approved", to: 'submissions#approved_submissions', as: :company_approved
  get    "submissions/:company_name/denied", to: 'submissions#denied_submissions', as: :company_denied
  get    "submissions/approved/all", to: 'submissions#approved_index', as: :companies_approved
  get    "submissions/denied/all", to: 'submissions#denied_index', as: :companies_denied
end
