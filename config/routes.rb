Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#show'

  resources :categories, only: [:index, :show]
end
