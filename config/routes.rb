Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#show'

  resources :category, controller: :categories, only: [:index, :show]
  resources :users, only: :show
end
