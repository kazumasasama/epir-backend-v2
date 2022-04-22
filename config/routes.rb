Rails.application.routes.draw do
  
  resources :users
  resources :menus
  resources :events
  resources :event_menus
end
