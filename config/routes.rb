Rails.application.routes.draw do
  root to: 'home#index'

  resources :companies, only: [:index]
  resources :jobs, only: [:index]

  get "/companies/inactive_companies", to: 'companies#inactive_companies', as: :inactive_companies
  get "/companies/active_companies", to: 'companies#active_companies', as: :active_companies

  get ':company_name/jobs/:job_title', to: 'company/jobs#show', as: "company_job"
  get '/companies/:company_name', to: "companies#show", as: "company"

  get '/jobs/new/', to: 'jobs#new', as: :create_jobs
  get '/jobs/:company_id/new', to: 'jobs#new', as: :create_company_jobs
  post '/jobs/create', to: 'jobs#create'
  get '/jobs/:company_id/jobs', to: 'jobs#store_jobs', as: :store_jobs
  get '/jobs/:id/edit', to: 'jobs#edit', as: :job_edit
  patch '/jobs/:id/jobs', to: 'jobs#update', as: :update_job
  # get '/jobs/:title', to: 'jobs#show', as: :job

  get "/companies/activate/:company_name", to: 'companies#activate_company', as: :activate_company
  patch "/companies/inactivate/:company_name", to: 'companies#inactivate_company', as: :inactivate_company
  get "/companies/:company_id/edit", to: 'companies#edit', as: :update_company
  patch "/companies/:company_name", to: 'companies#update'

  resources :companies, only: [:index, :show]

  post "/companies", to: 'companies#create'

  resources :users, only: [:new, :create]
  get "/users/:company_id/new", to: 'users#new', as: :new_admin_user
  get '/search/jobs', to: 'search#show', as: :search_job

  get    "/favorites", to: 'favorites#show', as: :favorites
  resources :favorites, only: [:create, :destroy]
  # get    "/favorites", to: 'favorites#show'

  resources :users_jobs, only: [:create]
  get '/my-submissions', to: "users_jobs#show", as: :my_jobs
  resources :saved_favorites, only: [:create]

  get '/my-favorites', to: "saved_favorites#index", as: :my_favorites

  get "/dashboard/all_users", to: 'users#index', as: :view_all_users
  get "/dashboard", to: "users#show"
  get "/dashboard/platform_admin",to: "users#show", as: :platform_admin_dashboard
  get "/dashboard/store_admin", to: "users#show", as: :store_admin_dashboard
  get "/dashboard/:company_id/view_store_admins", to: 'users#admin_index', as: :view_store_admins
  get    "/login", to: "sessions#new", as: :login
  post   "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get    "/about_us", to: 'home#about_us', as: :about_us
  get    "/contact_us", to:'contact_us#new', as: :contact_us

  post   "/contact_us", to:'contact_us#create'
  get    "/contact_us/all", to: 'contact_us#index', as: :customer_inquiries
  get    "/contact_us/:id", to: 'contact_us#show', as: :customer_inquiry
  delete "/contact_us/:id", to: 'contact_us#delete'
  # get    "/favorites", to: 'favorites_jobs#show', as: :favorites

  get    "submissions", to: 'submissions#new', as: :submissions
  post   "submissions", to: 'submissions#create'
  get    "submissions/pending", to: 'submissions#index', as: :submissions_status
  get    "submissions/:company_name", to: 'submissions#show', as: :company_submission_status
  get    "submissions/:company_name/approved", to: 'submissions#approved_submissions', as: :company_approved
  get    "submissions/:company_name/denied", to: 'submissions#denied_submissions', as: :company_denied
  get    "submissions/approved/all", to: 'submissions#approved_index', as: :companies_approved
  get    "submissions/denied/all", to: 'submissions#denied_index', as: :companies_denied

end
