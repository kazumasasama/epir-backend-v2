Rails.application.routes.draw do
  
  post "/sessions" => "sessions#create"
  
  resources :businesses, only: %i[show create update]
  resources :configs, only: %i[show create update]
  resources :closing_days, only: %i[index create update destroy]

  resources :users
  post "/users-statics" => "users#usersStatics"
  
  resources :statuses, only: %i[index create update]
  resources :categories, only: %i[show index create update]
  resources :menus
  get "/grouped-menus" => "menus#grouped"
  
  resources :business_times
  resources :event_menus
  
  resources :events
  post "/monthly-report" => "events#monthlyReport"
  
  post "/checkout" => "payments#checkout"
  post "/secret" => "payments#secret"
  
end