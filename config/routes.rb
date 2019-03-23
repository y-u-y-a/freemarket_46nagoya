Rails.application.routes.draw do

  root 'items#index'

  post 'users/card_create' => 'users#card_create'
  delete 'users/card_delete' => 'users#card_delete'

  match 'category_select', to: 'items#category_select', via: [:get, :post]
  match 'child_category_select', to: 'items#child_category_select', via: [:get, :post]

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get 'phone_number' => 'users/registrations#phone_number'
    get 'address' => 'users/registrations#address'
    get 'credit' => 'users/registrations#credit'
  end

  resources :users do
    get :to_signup,            on: :collection
    get :logout,               on: :collection
    get :payment_method,       on: :collection
    get :card_registration,    on: :collection
    get :indentification,      on: :collection
    get :trading,              on: :collection
    get :purchased,            on: :collection
    get :transaction_page,     on: :collection
    get :exhibition,           on: :collection
    get :seller_trading,       on: :collection
    get :sold_page,            on: :collection
  end

  resources :items do
    get :buy,                  on: :collection
    get :all_brands_show,      on: :collection
    get :all_categories_show,  on: :collection
    get :buy, on: :member
    post :pay, on: :member
  end

end
