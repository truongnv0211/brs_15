Rails.application.routes.draw do

  devise_for :users

  root "static_pages#home"

  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  resources :books
  resources :reviews
  resources :comments
  resources :requests, only: [:index, :create, :destroy]
  resources :users, only: [:index, :show] do
    resources :readings, only: :index
  end
  resources :favorites, only: [:index, :create, :destroy]
  resources :readings, except: [:edit, :new, :show]
  resources :relationships, only: [:create, :destroy]

  get "/users/:id/:type" => "relationships#index", as: "follow"

  namespace :admin do
    root "dashboards#home"
    resources :requests do
      collection do
        post :batch_update
      end
    end
    resources :categories
    resources :books
    resources :users, except: [:edit, :update]
  end
end
