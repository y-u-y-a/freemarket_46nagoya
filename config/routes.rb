Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  resources :users do
    get :payment_method,   on: :collection
    get :card_registration, on: :collection
  end
  resources :items,only: [:index,:new]
  resources :users,only: [:index,:show]
end
