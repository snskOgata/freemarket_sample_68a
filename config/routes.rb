Rails.application.routes.draw do
  devise_for :users
  root to: 'sales#index'
  resources :category, controller: :categories, only: [:index, :show, :new]
end
