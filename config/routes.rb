Rails.application.routes.draw do
  devise_for :users
  root to: 'sales#index'
  resources :sales, only: [:new, :show]
  resources :category, controller: :categories, only: [:index, :show]
  resources :users, only: :show
  namespace :mypages do
    get "index"
    get "new"
    get "logout"
  end
end


