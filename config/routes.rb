Rails.application.routes.draw do
  
  post "/sessions" => "sessions#create"
  
  resources :users
  resources :menus
  resources :business_times
  
  resources :events
  post "/monthly-report" => "events#monthlyReport"
  
  resources :event_menus
  
end
