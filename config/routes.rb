Rails.application.routes.draw do
  
  post "/sessions" => "sessions#create"
  
  resources :users
  resources :menus
  resources :events
  resources :event_menus
  resources :business_times
end
