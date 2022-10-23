Rails.application.routes.draw do
  
  resources :businesses,            only: %i[show create update]
  resources :configs,               only: %i[show create update]
  resources :closing_days,          only: %i[index create update destroy]
  resources :statuses,              only: %i[index create update]
  resources :categories,            only: %i[show index create update]
  resources :account_activations,   only: %i[edit]
  resources :users
  resources :menus
  resources :business_times
  resources :event_menus
  resources :events
  
  post "/sessions" =>         "sessions#create"
  post "/users-statics" =>    "users#usersStatics"
  get "/grouped-menus" =>     "menus#grouped"
  post "/monthly-report" =>   "events#monthlyReport"
  post "/checkout" =>         "payments#checkout"
  post "/secret" =>           "payments#secret"
  
end