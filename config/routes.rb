Rails.application.routes.draw do
  root 'items#index'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  resources :users do
    get :to_signup,            on: :collection
    get :logout,               on: :collection
    get :payment_method,       on: :collection
    get :card_registration,    on: :collection
    get :indentification,      on: :collection
  end
  resources :items do
    get :buy, on: :collection
  end
  resources :items,only: [:index,:new,:create,:show]
  resources :users,only: [:index,:show]
end
