Rails.application.routes.draw do
  devise_for :users
  root to: 'sales#index'
  resources :category, controller: :categories, only: [:index, :show]
  resources :users, only: :show
  resources :sales, only: :new
  namespace :mypages do
    get "index"
    get "new"
    get "logout"
  end

end


