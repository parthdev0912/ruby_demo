Rails.application.routes.draw do
  resources :sessions, only: [:create, :new]
  resources :meetings, only: [:index]
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "sessions#new"
end
