Rails.application.routes.draw do
  root to: 'homes#show'

  resources :categories, only: :show
end
