Rails.application.routes.draw do
  resources :row_values
  resources :tables
  resources :columns
  resources :rows
  resources :databases
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
