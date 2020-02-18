Rails.application.routes.draw do
  devise_for :users
  root to: 'sales#index'
  root to: 'homes#show'


  resources :sales, only: :show
  resources :category, controller: :categories, only: [:index, :show]
  resources :users, only: :show
  namespace :mypages do
    get "index"
    get "new"
    get "logout"
  end
end


