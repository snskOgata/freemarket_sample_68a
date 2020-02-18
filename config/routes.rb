Rails.application.routes.draw do
  devise_for :users
  root to: 'sales#index'
  root to: 'homes#show'
  # resources :sales, controller: :sales, only: [:index]
  resources :category, controller: :categories, only: [:index, :show]
end
