Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root to: 'homes#show'
  resources :users, only: [:edit, :update, :destroy]
  root to: 'sales#index'
  root to: 'homes#show'
  resources :category, controller: :categories, only: [:index, :show]
end
