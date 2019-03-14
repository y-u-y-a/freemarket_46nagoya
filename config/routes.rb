Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  resources :users do
    get :signup,            on: :collection
    get :login,             on: :collection
    get :logout,            on: :collection
    get :payment_method,    on: :collection
    get :card_registration, on: :collection
    get :indentification,   on: :collection
  end
  resources :items do
    get :buy, on: :collection
  end
<<<<<<< HEAD
  resources :items,only: [:index,:new,:create]
=======
  resources :items,only: [:index,:new,:show]
>>>>>>> tsurutadesu/master
  resources :users,only: [:index,:show]
end
