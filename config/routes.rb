Rails.application.routes.draw do
  root 'items#index'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  devise_scope :user do
    get 'phone_number' => 'users/registrations#phone_number'
    get 'address' => 'users/registrations#address'
    get 'payment_method' => 'users/registrations#payment_method'
  end
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
end
