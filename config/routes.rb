Rails.application.routes.draw do
  
  post "/sessions" => "sessions#create"
  
  resources :users
  resources :menus

  resources :events
  post "/events-monthly" => "events#monthly"

  resources :event_menus
  resources :business_times
end
