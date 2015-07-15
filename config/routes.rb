Rails.application.routes.draw do

  devise_for :users

  root "static_pages#home"

  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  resources :books
  resources :reviews
  resources :comments
  resources :requests
  resources :users, only: [:index, :show]
  resources :favorites, only: [:index, :create, :destroy]

  namespace :admin do
    root "dashboards#home"
    resources :categories
    resources :books
    resources :users, except: [:edit, :update]
  end
end
