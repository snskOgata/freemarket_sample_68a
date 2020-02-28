Rails.application.routes.draw do
  get 'listings/listing'
  get 'listings/in_progress'
  get 'listings/completed'
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
  resources :sales, only: [:new, :show, :create, :edit, :destroy] do
    resources :orders, only: [:new, :create]
  end
  resources :category, controller: :categories, only: [:index, :show]

  resource :mypage, only: [:show]
  scope :mypage do
    resources :cards, only: [:new, :index, :destroy, :create]
  end

  get '*anything', to: 'errors#error_page'
  get 'error', to: 'errors#error_page'
end


