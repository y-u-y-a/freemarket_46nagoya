Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  resources :users do
    get :signup, on: :collection
    get :login     , on: :collection
  end
  resources :items,only: [:index,:new]
  resources :users,only: [:index,:show]
end
