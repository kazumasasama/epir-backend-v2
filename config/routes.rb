Rails.application.routes.draw do
  
  post "/sessions" => "sessions#create"
  
  resources :businesses, only: %i[show create update]
  resources :configs, only: %i[show create update]

  resources :users
  post "/users-statics" => "users#usersStatics"
  
  resources :statuses, only: %i[index create update]
  resources :menus
  resources :business_times
  resources :event_menus
  
  resources :events
  post "/monthly-report" => "events#monthlyReport"
  
  post "/checkout" => "payments#checkout"
  post "/secret" => "payments#secret"
  
end