Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  resources :users do
<<<<<<< HEAD
    get :signup, on: :collection
    get :login     , on: :collection
=======
    get :payment_method,   on: :collection
    get :card_registration, on: :collection
>>>>>>> tsurutadesu/master
  end
  resources :items,only: [:index,:new]
  resources :users,only: [:index,:show]
end
