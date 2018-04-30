Rails.application.routes.draw do
  resources :row_values
  resources :tables
  resources :columns
  resources :rows
  resources :databases do
    resources :queries
  end
  resources :projects
    
  post 'token', to: 'authentication#authenticate'
end
