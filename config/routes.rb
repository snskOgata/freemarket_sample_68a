Rails.application.routes.draw do
  # ユーザ関連
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  get "logout", to: "mypages#logout"

  # 商品関連
  root to: 'sales#index'
  resources :sales, only: [:new, :show, :create, :edit, :update, :destroy] do
    post "shipped", to: "shipped"
    resources :orders, only: [:new, :create]
  end
  resources :category, controller: :categories, only: [:index, :show]

  resource :mypage, only: [:show]
  scope :mypage do
    resources :cards, only: [:new, :index, :destroy, :create]
    namespace :listings do
      get 'listing'
      get 'in_progress'
      get 'completed'
      get 'purchasing'
      get 'purchased'
    end
  end

  get '*anything', to: 'errors#error_page' if Rails.env.production?
  get 'error', to: 'errors#error_page'
end


