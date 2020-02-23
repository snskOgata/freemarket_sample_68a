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
  root to: 'sales#index'
  resources :users, only: [:edit, :update, :destroy, :show]
  resources :sales, only: [:new, :show, :create]
  resources :category, controller: :categories, only: [:index, :show]
  namespace :mypages do
    get "index"
    get "new"
    get "logout"
  end

end


