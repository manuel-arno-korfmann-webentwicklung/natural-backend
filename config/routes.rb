Rails.application.routes.draw do
  resources :fields
  resources :tables
  resources :databases
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
