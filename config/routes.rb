Rails.application.routes.draw do
  root "static_pages#home"

  get "help" => "static_pages#help"
  get "about" => "static_pages#about"

  namespace :admin do
    root "dashboards#home"
  end

  devise_for :users
end
