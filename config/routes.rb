Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#show'
  resources :users, only: [:edit, :update, :destroy]
end
