Rails.application.routes.draw do
  
  post "/sessions" => "sessions#create"
  
  resources :users
  post "/users-statics" => "users#usersStatics"

  resources :menus
  resources :business_times
  
  resources :events
  post "/monthly-report" => "events#monthlyReport"
  
  resources :event_menus
  
  post "/checkout" => "payments#checkout"
  post "/secret" => "payments#secret"

  post "/webhook" => "payments#webhook"
  
end
