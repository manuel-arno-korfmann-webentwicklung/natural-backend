# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

Rails.application.routes.draw do
  resources :row_values
  resources :tables
  resources :columns
  resources :rows
  resources :databases do
    resources :queries
  end
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
