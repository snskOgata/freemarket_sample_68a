Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#show'

  resources :category, controller: :categories, only: [:index, :show]
  resources :users, only: :show
  resources :mypages, only: [:index, :new, :destroy] do
    collection do
      get 'logout'
    end
  end
end


